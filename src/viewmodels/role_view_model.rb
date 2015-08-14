class RoleViewModel
  attr_reader :role, :standing

  def initialize(role)
    autowired(MapService)
    @player = @role = role
    @sound_eat_food = MediaUtil::get_sample('eat.wav')
    @font = Gosu::Font.new(15)
    init_animations
    @eating_food_vm = nil
    @auto_move_enabled = false
    @speed = 2.0
    @arrive_call_back = nil
    stop
  end

  def init_animations
    role = @role.role_type.to_s
    %w(stand walk run eat hold_food).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{role}_#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def stop
    @standing = true
    @running = false
  end

  def eat_food(food)
    @sound_eat_food.play
    @role.start_eat food
    @eating_food_vm = FoodViewModel.new food
  end

  def clear_food
    @eating_food_vm = nil
    @role.eat_done
  end

  def set_auto_move_to(x, y, &arrive_call_back)
    @auto_move_enabled = true
    @auto_move_angle = Gosu::angle(@role.x, @role.y, x, y)
    @auto_move_dest = {:x => x, :y => y}
    @arrive_call_back = arrive_call_back
  end

  def disable_auto_move
    @auto_move_enabled = false
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

  def set_state(state)
    @role.state = state
    change_anim
  end

  def update_state
    set_state get_state
  end

  def get_state
    if @role.eating?
      if @standing
        return Role::State::EATING
      else
        return Role::State::HOLDING_FOOD
      end
    else
      if @standing
        return Role::State::STANDING
      else
        return @running ? Role::State::RUNNING : Role::State::WALKING
      end
    end
  end

  def draw
    draw_role_anim
    @eating_food_vm.draw unless @eating_food_vm.nil?
    draw_level_and_name
  end

  def control_move(angle, map_vm)
    do_move angle, map_vm
  end

  private

  def lv_image
    LevelUtil.image(@role.lv)
  end

  def change_anim
    state = @role.state.to_s

    direction = ''
    if Direction::is_direct_to_left(@role.direction)
      direction = 'left'
    elsif Direction::is_direct_to_right(@role.direction)
      direction = 'right'
    elsif Direction::is_direct_to_up(@role.direction)
      direction = 'up'
    elsif Direction::is_direct_to_down(@role.direction)
      direction = 'down'
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_anim(key)
    AnimationManager.get_anim key
  end

  def draw_role_anim
    @current_anim.draw(@role.x, @role.y - 26, ZOrder::Player)
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
      @running = false
      @standing = true
      move_to_location(x, @role.y) unless map_vm.tile_block? x, @role.y
      move_to_location(@role.x, y) unless map_vm.tile_block? @role.x, y
    else
      move_to_location(x, y)
    end
  end

  def get_speed
    @running ? @speed * 2 : @speed
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
end