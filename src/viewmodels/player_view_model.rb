class PlayerViewModel
  attr_reader :score, :role

  def initialize(player)
    @player = @role = player
    @beep = MediaUtil::get_sample("pickup.wav")
    @speed = 2.0
    @score = 0
    init_animations
    @move_timestamp = Gosu::milliseconds
    @standing = true
    @running = true
    @eating_food_vm = nil
    @update_times = 0
    @auto_move_enabled = false
  end

  def update
    map_vm = MapManager.current_map
    auto_move map_vm
    @player.update_eating_food
    have_a_rest if @standing
    change_state
    change_anim
    eat if @standing
    @player.refresh_exp if @update_times % 60 == 0
    @update_times += 1
  end

  def draw
    # @image.draw_rot(@x, @y, ZOrder::Player, 0)
    # puts "@player.state: #{@player.state} @current_anim: #{@current_anim}"
    @current_anim.draw(@player.x, @player.y - 26, ZOrder::Player)
    @eating_food_vm.draw unless @eating_food_vm.nil?
  end

  def move(direction, map_vm)
    if direction != Direction::NONE
      @auto_move_enabled = false
      @player.direction = direction
      angle = Direction::to_angle direction
      do_move(angle, map_vm)
    else
      @standing = true
    end
  end

  def pick_up(item_vm)
    item = item_vm.item
    @score += 1
    @beep.play
    if item.respond_to? :eatable?
      eat_food item
    end
  end

  # 自动拾取
  def collect_foods(food_mvs)
    food_mvs.reject! do |food_mv|
      food = food_mv.food
      if Gosu::distance(@player.x, @player.y, food.x, food.y) < 60
        @score += 1
        # @player.inc_exp 50
        @player.package << food
        @beep.play
        true
      else
        false
      end
    end
  end

  # def start_eat_food
  #   return if @player.eating?
  #   food = @player.package.items.find {|item| item.respond_to? :eatable?}
  #   unless food.nil?
  #     eat_food food
  #   end
  # end

  def discard(food_vms)
    item = @player.discard
    return if item.nil?
    if item.respond_to? :eatable?
      food_vm = FoodViewModel.new item
      food_vms << food_vm
    end
  end

  def set_destination(x, y)
    @auto_move_enabled = true
    @auto_move_angle = Gosu::angle(@player.x, @player.y, x, y)
    @auto_move_dest = {:x => x, :y => y}
  end

  private

  def get_anim(key)
    AnimationManager.get_anim key
  end

  def init_animations
    %w(stand walk run eat hold_food).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def change_state
    if @player.eating?
      if @standing
        @player.state = Role::State::EATING
      else
        @player.state = Role::State::HOLDING_FOOD
      end
    else
      if @standing
        @player.state = Role::State::STANDING
      else
        @player.state = @running ? Role::State::RUNNING : Role::State::WALKING
      end
    end
  end

  def change_anim
    state = @player.state.to_s

    direction = ''
    if Direction::is_direct_to_left(@player.direction)
      direction = 'left'
    elsif Direction::is_direct_to_right(@player.direction)
      direction = 'right'
    elsif Direction::is_direct_to_up(@player.direction)
      direction = 'up'
    elsif Direction::is_direct_to_down(@player.direction)
      direction = 'down'
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_speed
    @running ? @speed * 2 : @speed
  end

  def eat_food food
    @player.start_eat food
    @eating_food_vm = FoodViewModel.new food
    @player.package.discard food
  end

  def eat
    @player.eat
    @eating_food_vm = nil unless @player.eating?
  end

  def auto_move(map_vm)
    if @auto_move_enabled
      x_diff = @auto_move_dest[:x] - @player.x
      y_diff = @auto_move_dest[:y] - @player.y
      if x_diff.abs > y_diff.abs
        @player.direction = x_diff < 0 ? Direction::LEFT : Direction::RIGHT
      else
        @player.direction = y_diff < 0 ? Direction::UP : Direction::DOWN
      end
      do_move @auto_move_angle, map_vm, @auto_move_dest
    end
  end

  def do_move(angle, map_vm, destination = nil)
    @running = @player.hp > 0
    speed = get_speed

    unless destination.nil?
      dest_x = destination[:x]
      dest_y = destination[:y]
      if Gosu::distance(@player.x, @player.y, dest_x, dest_y) <= speed
        move_to_location(dest_x, dest_y)
        @auto_move_enabled = false
        return
      end
    end

    x = @player.x + Gosu::offset_x(angle, speed)
    y = @player.y + Gosu::offset_y(angle, speed)

    if map_vm.tile_block? x, y
      # 继续单方向检测
      @running = false
      @standing = true
      move_to_location(x, @player.y) unless map_vm.tile_block? x, @player.y
      move_to_location(@player.x, y) unless map_vm.tile_block? @player.x, y
    else
      move_to_location(x, y)
    end
  end

  def move_to_location(x, y)
    @standing = false
    @player.x = x
    @player.y = y
    @move_timestamp = Gosu::milliseconds
    @player.dec_hp(GameConfig::RUNNING_HP_DEC) if @running
  end

  def have_a_rest
    @player.inc_hp(GameConfig::REST_HP_INC)
  end
end