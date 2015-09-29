class RoleViewModel
  attr_reader :role, :standing, :hiting, :battered
  attr_accessor :area_id, :vehicle

  def initialize(role)
    autowired(MapService)
    @player = @role = role
    @sound_eat_food = MediaUtil::get_sample('eat.wav')
    @sound_collect_rubbish = MediaUtil::get_sample('collect_rubbish.wav')
    @font = Gosu::Font.new(15)
    init_animations
    @eating_food_vm = nil
    @auto_move_enabled = false
    @speed = 4.2
    @arrive_call_back = nil
    stop
    @area_id = nil
    @vehicle = nil
    @driving = false
    @chat_bubble_vm = ChatBubbleViewModel.new
    @update_times = 0
    @hiting = false
    @battered = false  # 被打扁的
    @sound_hit = MediaUtil.get_sample 'hit.wav'
    @sound_being_battered = MediaUtil.get_sample 'being_battered.wav'
  end

  def driving?
    @driving && !@vehicle.nil?
  end

  def set_driving(value)
    @driving = value
    if driving?
      @role.vehicle = @vehicle.key
    else
      @role.vehicle = nil
    end
    value
  end

  def driving
    @driving
  end

  def drive(vehicle_key)
    if vehicle_key.nil?
      set_driving false
      return
    end
    return if driving? && @vehicle.key == vehicle_key
    @vehicle = EquipmentViewModelFactory.create_vehicle vehicle_key
    set_driving true
  end

  def init_animations
    role_type = @role.role_type.to_s
    %w(stand walk run eat hold_food drive hit turn_to_battered battered collecting_rubbish).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{role_type}_#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def appear_in_new_area
    disable_auto_move
    update_state
  end

  def stop
    @standing = true
    @running = false
  end

  def eat_food(food_vm)
    @sound_eat_food.play
    eat_food_quietly food_vm
  end

  def eat_food_quietly(food_vm)
    @role.start_eat food_vm.food
    @eating_food_vm = food_vm
  end

  def clear_food
    @eating_food_vm = nil
    @role.eat_done
  end

  def collect_rubbish(quiet=false)
    @sound_collect_rubbish.play unless quiet
    @collecting_rubbish = true
    @collecting_rubbish_end_time = Gosu::milliseconds + 430
    update_state
  end

  def set_auto_move_to(x, y, &arrive_call_back)
    @auto_move_enabled = true
    @auto_move_angle = Gosu::angle(@role.x, @role.y, x, y)
    @auto_move_dest = {:x => x, :y => y}
    @arrive_call_back = arrive_call_back
  end

  def disable_auto_move
    @auto_move_enabled = false
    stop
  end

  def auto_move(map_vm)
    if @auto_move_enabled
      x_diff = @auto_move_dest[:x] - @role.x
      y_diff = @auto_move_dest[:y] - @role.y
      if x_diff.abs > y_diff.abs
        @role.direction = x_diff < 0 ? Direction::LEFT : Direction::RIGHT
      else
        @role.direction = y_diff < 0 ? Direction::UP : Direction::DOWN
      end
      do_move @auto_move_angle, map_vm, @auto_move_dest
    end
  end

  def update_eating_food
    @role.update_eating_food(*get_actual_role_location)
  end

  def set_state(state)
    @role.state = state
    change_anim
  end

  def update_state
    set_state get_state
  end

  def get_state
    if @battered
      return Role::State::TURN_TO_BATTERED if Gosu::milliseconds < @turn_to_battered_end_time
      return Role::State::BATTERED
    end

    if @hiting
      return Role::State::HIT
    end

    if @collecting_rubbish
      return Role::State::COLLECTING_RUBBISH
    end

    if @role.eating?
      if @standing
        return Role::State::EATING
      else
        if driving?
          return Role::State::HOLDING_FOOD
        else
          return Role::State::HOLDING_FOOD
        end
      end
    else
      if @standing
        return Role::State::STANDING
      else
        if driving?
          return Role::State::DRIVING
        else
          return @running ? Role::State::RUNNING : Role::State::WALKING
        end
      end
    end
  end

  def set_direction(direction)
    @role.direction = direction
  end

  def draw
    draw_role_anim
    draw_equipment
    @eating_food_vm.draw unless @eating_food_vm.nil?
    draw_level_and_name
    draw_chat_bubble
  end

  def control_move(angle, map_vm)
    do_move angle, map_vm
  end

  def add_chat_content(content)
    @chat_bubble_vm.add_content content
  end

  def update
    @update_times += 1
    if @update_times % 10 == 0
      @chat_bubble_vm.update_content
    end
    if @hiting
      @hiting = false if Gosu::milliseconds >= @hit_end_time
    end
    if @battered
      @battered = false if Gosu::milliseconds >= @battered_end_time
    end
    if @collecting_rubbish
      @collecting_rubbish = false if Gosu::milliseconds >= @collecting_rubbish_end_time
    end
  end

  def hit
    @hiting = true
    @hit_end_time = Gosu::milliseconds + 560
    update_state
    @current_anim.goto_begin
    @sound_hit.play
  end

  def being_battered
    @battered = true
    @turn_to_battered_end_time = Gosu::milliseconds + 270
    @battered_end_time = @turn_to_battered_end_time + 6000
    @sound_being_battered.play
  end

  private

  def lv_image
    LevelUtil.image(@role.lv)
  end

  def change_anim
    state = @role.state.to_s
    direction = Direction::to_direction_text(@role.direction)
    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_anim(key)
    AnimationManager.get_anim key
  end

  def draw_role_anim
    x, y = get_actual_role_location
    @current_anim.draw(x, y, ZOrder::Player)
  end

  def draw_equipment
    if driving?
      @vehicle.draw(@role.x, @role.y, @role.direction)
    end
  end

  def draw_level_and_name
    name_width = @font.text_width(@role.name)
    lv_img_width = 15
    whole_width = lv_img_width + 2 + name_width
    level_left = @role.x - whole_width / 2
    level_height = @role.y + 14
    draw_text_with_border(@role.name, level_left + lv_img_width + 2, level_height, ZOrder::Player,
                          1, 1, 0xFF_CFC2BC, 0xFF_251B00)
    lv_image.draw(level_left, level_height, ZOrder::Player)
  end

  def draw_text_with_border(text, x, y, z, scale_x, scale_y, color, border_color)
    @font.draw(text, x, y-1, z, scale_x, scale_y, border_color)
    @font.draw(text, x, y+1, z, scale_x, scale_y, border_color)
    @font.draw(text, x-1, y, z, scale_x, scale_y, border_color)
    @font.draw(text, x+1, y, z, scale_x, scale_y, border_color)
    @font.draw(text, x, y, z, scale_x, scale_y, color, :additive)
  end

  def draw_chat_bubble
    x, y = get_actual_role_location
    @chat_bubble_vm.draw_with_target x, y - 30
  end

  def do_move(angle, map_vm, destination = nil)
    @running = @role.hp > 0
    speed = get_speed

    unless destination.nil?
      dest_x = destination[:x]
      dest_y = destination[:y]
      if Gosu::distance(@role.x, @role.y, dest_x, dest_y) <= speed
        move_to_location(dest_x, dest_y)
        complete_auto_move
        @running = false
        @standing = true
        return
      end
    end

    x = @role.x + Gosu::offset_x(angle, speed)
    y = @role.y + Gosu::offset_y(angle, speed)

    if map_vm.tile_block? x, y
      disable_auto_move
      # 继续单方向检测
      move_to_location(x, @role.y) unless map_vm.tile_block? x, @role.y
      move_to_location(@role.x, y) unless map_vm.tile_block? @role.x, y
    else
      move_to_location(x, y)
    end
  end

  def get_speed
    running = @running && !@battered
    speed_rate = 1.0
    speed_rate -= 0.5 unless running
    speed_rate -= 0.25 if @battered || @role.eating?
    speed_rate += @vehicle.speed_up if driving?
    @speed * speed_rate
  end

  def move_to_location(x, y)
    @standing = false
    @role.x = x
    @role.y = y
    @move_timestamp = Gosu::milliseconds
    @role.dec_hp(GameConfig::RUNNING_HP_DEC) if @running
  end

  def complete_auto_move
    disable_auto_move
    @arrive_call_back.call unless @arrive_call_back.nil?
  end

  def get_actual_role_location
    x, y = @role.x, @role.y - 30
    y = y - @vehicle.vehicle_body_height if driving?
    [x, y]
  end
end