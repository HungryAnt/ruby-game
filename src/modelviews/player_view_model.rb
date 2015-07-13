class PlayerViewModel
  attr_reader :score

  def initialize(player, x, y)
    @player = player
    @x, @y = x, y
    @beep = MediaUtil::get_sample("pickup.wav")
    @speed = 2.0
    @score = 0
    init_animations
    @direction = Direction::DOWN
    @move_timestamp = Gosu::milliseconds
    @standing = true
    @running = true
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
  end

  def draw
    #@image.draw_rot(@x, @y, ZOrder::Player, 0)
    anim = @anim_stand_down

    if @standing
      if is_direct_to Direction::LEFT
        anim = @anim_stand_left
      elsif is_direct_to Direction::RIGHT
        anim = @anim_stand_right
      elsif is_direct_to Direction::UP
        anim = @anim_stand_up
      elsif is_direct_to Direction::DOWN
        anim = @anim_stand_down
      end
    else
      if is_direct_to Direction::LEFT
        anim = @running ? @anim_run_left : @anim_walk_laft
      elsif is_direct_to Direction::RIGHT
        anim = @running ? @anim_run_right : @anim_walk_right
      elsif is_direct_to Direction::UP
        anim = @running ? @anim_run_up : @anim_walk_up
      elsif is_direct_to Direction::DOWN
        anim = @running ? @anim_run_down : @anim_walk_down
      end
    end

    anim.draw(@x, @y, ZOrder::Player)
  end

  def is_direct_to(direction)
    @direction & direction == direction
  end

  def move direction, map
    if direction != Direction::NONE
      @direction = direction

      angle = Direction::to_angle direction

      puts "hp: #{@player.hp}"
      @running = @player.hp > 0

      speed = @running ? @speed * 2 : @speed

      x = @x + Gosu::offset_x(angle, speed)
      y = @y + Gosu::offset_y(angle, speed)

      if map.tile_block? x, y
        # 继续单方向检测
        @running = false
        @standing = true
        do_move(x, @y) unless map.tile_block? x, @y
        do_move(@x, y) unless map.tile_block? @x, y
      else
        do_move(x, y)
      end
    else
      @standing = true
    end

    have_a_rest if @standing
  end

  def have_a_rest
    @player.inc_hp(0.05)
  end

  def do_move(x, y)
    @standing = false
    @x = x
    @y = y
    @move_timestamp = Gosu::milliseconds
    @player.dec_hp(0.2) if @running
  end

  def collect_foods(foods)
    foods.reject! do |food|
      if Gosu::distance(@x, @y, food.x, food.y) < 60
        @score += 1
        @beep.play
        true
      else
        false
      end
    end
  end
end