class RoleViewModel
  attr_reader :role, :standing, :hitting, :battered, :finger_hitting, :farting, :head_hitting
  attr_accessor :area_id, :vehicle

  def initialize(role)
    autowired(MapService, HitService)
    @player = @role = role
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
    init_hit_components
    init_sound
    reset_durable_state
  end

  def init_hit_components
    @hitting = false
    @battered = false  # 被打扁的
    @battered_by_hit_type = Role::State::HIT
  end

  def init_sound
    @sound_eat_food = MediaUtil::get_sample('eat.wav')
    @sound_collect_rubbish = MediaUtil::get_sample('collect_rubbish.wav')
    @sound_smash = MediaUtil.get_sample 'smash.wav'
    @sound_collect_nutrient = MediaUtil.get_sample 'collect_nutrient.wav'
  end

  def y
    @role.y
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
    %w(stand walk run eat hold_food drive hit turn_to_battered battered
      collecting_rubbish scare lecherous bye cry laugh
      finger_hit turn_to_finger_battered finger_battered
      fart head_hit turn_to_stunned stunned).each do |state|
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
    @collecting_rubbish_end_time = Gosu::milliseconds + 420
    update_state
  end

  def collect_nutrient(quiet=false)
    @sound_collect_nutrient.play unless quiet
  end

  def set_auto_move_to(x, y, &arrive_call_back)
    reset_durable_state
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
      adjust_to_suit_direction(@auto_move_dest[:x], @auto_move_dest[:y])
      do_move @auto_move_angle, map_vm, @auto_move_dest
    end
  end

  def adjust_to_suit_direction(target_x, target_y)
    @role.direction = calc_suit_direction target_x, target_y
  end

  def update_eating_food
    @role.update_eating_food(*get_actual_role_location)
  end

  def set_durable_state(state)
    @role.durable_state = state
    set_state(state)
  end

  def reset_durable_state
    @role.durable_state = Role::State::STANDING
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
      if Gosu::milliseconds < @turn_to_battered_end_time
        return @hit_service.get_turn_to_battered_state(@battered_by_hit_type)
      end
      return @hit_service.get_battered_state(@battered_by_hit_type)
    end

    if @hitting
      return @hit_service.get_hitting_state(@hit_type)
    end

    # if @finger_hitting
    #   return Role::State::FINGER_HIT
    # end
    #
    # if @farting
    #   return Role::State::FART
    # end
    #
    # if @head_hitting
    #   return Role::State::HEAD_HIT
    # end

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
        return @role.durable_state
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
    if driving_dragon? && @role.direction == Direction::UP
      draw_equipment
      draw_role_anim
    else
      draw_role_anim
      draw_equipment
    end

    @eating_food_vm.draw unless @eating_food_vm.nil?
    draw_level_and_name
    draw_chat_bubble
  end

  def driving_dragon?
    driving? && @vehicle.key.to_s.start_with?('dragon')
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
    if @hitting
      @hitting = false if Gosu::milliseconds >= @hit_end_time
    end
    if @battered
      @battered = false if Gosu::milliseconds >= @battered_end_time
    end
    # if @finger_hitting
    #   @finger_hitting = false if Gosu::milliseconds >= @finger_hit_end_time
    # end
    # if @farting
    #   @farting = false if Gosu::milliseconds >= @fart_end_time
    # end
    # if @head_hitting
    #   @head_hitting = false if Gosu::milliseconds >= @head_hit_end_time
    # end

    if @collecting_rubbish
      @collecting_rubbish = false if Gosu::milliseconds >= @collecting_rubbish_end_time
    end
  end

  def hit(sound=:hit)
    common_hit Role::State::HIT, true
    if sound == :hit
      @hit_service.play_hitting_sound(Role::State::HIT)
    elsif sound == :smash
      @sound_smash.play
    end
  end

  def common_hit(hit_type, quite=false)
    return unless @hit_service.is_hit? hit_type
    @hitting = true
    @hit_type = hit_type
    @hit_end_time = calc_end_time
    update_state
    @current_anim.goto_begin
    unless quite
      @hit_service.play_hitting_sound(hit_type)
    end
  end

  def being_battered(hit_type)
    return unless @hit_service.is_hit? hit_type
    @battered = true
    @battered_by_hit_type = hit_type
    @turn_to_battered_end_time = Gosu::milliseconds +
        @hit_service.get_turn_to_battered_duration_time(hit_type)
    @battered_end_time = @turn_to_battered_end_time +
        @hit_service.get_battered_duration_time(hit_type)
    @hit_service.play_battered_sound hit_type
  end

  # def finger_hit
  #   @finger_hitting = true
  #   @finger_hit_end_time = calc_end_time
  #   update_state
  #   @current_anim.goto_begin
  # end
  #
  # def fart
  #   @farting = true
  #   @fart_end_time = calc_end_time
  #   update_state
  #   @current_anim.goto_begin
  #   @sound_fart.play
  # end
  #
  # def head_hit
  #   @head_hitting = true
  #   @head_hit_end_time = calc_end_time
  #   update_state
  #   @current_anim.goto_begin
  # end

  private

  def calc_end_time
    Gosu::milliseconds + 585
  end

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
    GraphicsUtil.draw_text_with_border(@role.name, @font, level_left + lv_img_width + 2, level_height,
                                       ZOrder::Player, 1, 1, 0xFF_EFE2DC, 0xFF_251B00)
    lv_image.draw(level_left, level_height, ZOrder::Player)
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
    if @battered
      return 0 if @hit_service.cannot_move? @battered_by_hit_type
    end

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

  def calc_suit_direction(target_x, target_y)
    x_diff = target_x - @role.x
    y_diff = target_y - @role.y
    if x_diff.abs > y_diff.abs
      x_diff < 0 ? Direction::LEFT : Direction::RIGHT
    else
      y_diff < 0 ? Direction::UP : Direction::DOWN
    end
  end
end