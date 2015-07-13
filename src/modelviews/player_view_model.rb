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
    @anim_walk_laft = get_anim :walk_left
    @anim_walk_right = get_anim :walk_right
    @anim_walk_up = get_anim :walk_up
    @anim_walk_down = get_anim :walk_down

    @anim_stand_left = get_anim :stand_left
    @anim_stand_right = get_anim :stand_right
    @anim_stand_up = get_anim :stand_up
    @anim_stand_down = get_anim :stand_down

    @anim_run_left = get_anim :run_left
    @anim_run_right = get_anim :run_right
    @anim_run_up = get_anim :run_up
    @anim_run_down = get_anim :run_down

    @anim_eat_left = get_anim :eat_left
    @anim_eat_right = get_anim :eat_right
    @anim_eat_up = get_anim :eat_up
    @anim_eat_down = get_anim :eat_down

    @current_anim = @anim_stand_down
  end

  def change_anim
    anim = @anim_stand_down

    act = ''

    if @eating
      act = 'eat'
    elsif @standing
      act = 'stand'
    elsif @running
      act = 'run'
    else
      act = 'walk'
    end

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

    anim = self.instance_variable_get("@anim_#{act}_#{direction}")

    # if @standing
    #   if is_direct_to Direction::LEFT
    #     anim = @anim_stand_left
    #   elsif is_direct_to Direction::RIGHT
    #     anim = @anim_stand_right
    #   elsif is_direct_to Direction::UP
    #     anim = @anim_stand_up
    #   elsif is_direct_to Direction::DOWN
    #     anim = @anim_stand_down
    #   end
    # else
    #   if is_direct_to Direction::LEFT
    #     anim = @running ? @anim_run_left : @anim_walk_laft
    #   elsif is_direct_to Direction::RIGHT
    #     anim = @running ? @anim_run_right : @anim_walk_right
    #   elsif is_direct_to Direction::UP
    #     anim = @running ? @anim_run_up : @anim_walk_up
    #   elsif is_direct_to Direction::DOWN
    #     anim = @running ? @anim_run_down : @anim_walk_down
    #   end
    # end

    @current_anim = anim
  end

  def draw
    #@image.draw_rot(@x, @y, ZOrder::Player, 0)
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
        # ������������
        @running = false
        @standing = true
        do_move(x, @player.y) unless map.tile_block? x, @y
        do_move(@player.x, y) unless map.tile_block? @x, y
      else
        do_move(x, y)
      end
    else
      @standing = true
    end

    have_a_rest if @standing

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
    food = @player.package[0] if @player.package.size > 0
    @eating = true
  end
end