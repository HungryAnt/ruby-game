class PlayerViewModel
  attr_reader :score

  def initialize(player)
    @player = player
    @beep = MediaUtil::get_sample("pickup.wav")
    @speed = 2.0
    @score = 0
    init_animations
    @direction = Direction::DOWN
    @move_timestamp = Gosu::milliseconds
    @standing = true
    @running = true
    @eating_food_vm = nil
  end

  private def get_anim key
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
    if @player.eating
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
    if Direction::is_direct_to_left(@direction)
      direction = 'left'
    elsif Direction::is_direct_to_right(@direction)
      direction = 'right'
    elsif Direction::is_direct_to_up(@direction)
      direction = 'up'
    elsif Direction::is_direct_to_down(@direction)
      direction = 'down'
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def update
    @player.update_eating_food
  end

  def draw
    # @image.draw_rot(@x, @y, ZOrder::Player, 0)
    # puts "@player.state: #{@player.state} @current_anim: #{@current_anim}"
    @current_anim.draw(@player.x, @player.y, ZOrder::Player)
    @eating_food_vm.draw unless @eating_food_vm.nil?
  end

  def move(direction, map)
    if direction != Direction::NONE
      @direction = direction
      @player.direction = direction

      angle = Direction::to_angle direction

      @running = @player.hp > 0

      speed = @running ? @speed * 2 : @speed

      x = @player.x + Gosu::offset_x(angle, speed)
      y = @player.y + Gosu::offset_y(angle, speed)

      if map.tile_block? x, y
        # 继续单方向检测
        @running = false
        @standing = true
        do_move(x, @player.y) unless map.tile_block? x, @player.y
        do_move(@player.x, y) unless map.tile_block? @player.x, y
      else
        do_move(x, y)
      end
    else
      @standing = true
    end

    have_a_rest if @standing

    change_state
    change_anim
  end

  def have_a_rest
    @player.inc_hp(0.05)
  end

  def do_move(x, y)
    @standing = false
    @player.x = x
    @player.y = y
    @move_timestamp = Gosu::milliseconds
    @player.dec_hp(0.2) if @running
  end

  def collect_foods(food_mvs)
    food_mvs.reject! do |food_mv|
      food = food_mv.food
      if Gosu::distance(@player.x, @player.y, food.x, food.y) < 60
        @score += 1
        @player.inc_exp 50
        @player.package << food
        @beep.play
        true
      else
        false
      end
    end
  end

  def eat_food
    food = @player.package.items.find {|item| item.respond_to? :eatable?}
    unless food.nil?
      @player.eat food
      @eating_food_vm = FoodViewModel.new food
    end
  end
end