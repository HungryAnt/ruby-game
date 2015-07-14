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
    @eating = false # todo refactor to status
  end

  private def get_anim key
    AnimationManager.get_anim key
  end

  def init_animations
    # @anim_walk_left = get_anim :walk_left
    # @anim_walk_right = get_anim :walk_right
    # @anim_walk_up = get_anim :walk_up
    # @anim_walk_down = get_anim :walk_down
    #
    # @anim_stand_left = get_anim :stand_left
    # @anim_stand_right = get_anim :stand_right
    # @anim_stand_up = get_anim :stand_up
    # @anim_stand_down = get_anim :stand_down
    #
    # @anim_run_left = get_anim :run_left
    # @anim_run_right = get_anim :run_right
    # @anim_run_up = get_anim :run_up
    # @anim_run_down = get_anim :run_down
    #
    # @anim_eat_left = get_anim :eat_left
    # @anim_eat_right = get_anim :eat_right
    # @anim_eat_up = get_anim :eat_up
    # @anim_eat_down = get_anim :eat_down

    %w(stand walk run eat).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def change_anim
    state = @player.state.to_s

    direction = ''
    if is_direct_to Direction::LEFT
      direction = 'left'
    elsif is_direct_to Direction::RIGHT
      direction = 'right'
    elsif is_direct_to Direction::UP
      direction = 'up'
    elsif is_direct_to Direction::DOWN
      direction = 'down'
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def draw
    # @image.draw_rot(@x, @y, ZOrder::Player, 0)
    # puts "@player.state: #{@player.state} @current_anim: #{@current_anim}"
    @current_anim.draw(@player.x, @player.y, ZOrder::Player)
  end

  def is_direct_to(direction)
    @direction & direction == direction
  end

  def move(direction, map)
    if direction != Direction::NONE
      @direction = direction

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
        @player.state = Role::State::STANDING if @standing
      else
        do_move(x, y)
      end
    else
      @standing = true
      @player.state = Role::State::STANDING
    end

    have_a_rest if @standing

    change_anim
  end

  def have_a_rest
    @player.inc_hp(0.05)
  end

  def do_move(x, y)
    @standing = false
    @player.state = @running ? Role::State::RUNNING : Role::State::WALKING
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
    @player.eat food unless food.nil?
  end
end