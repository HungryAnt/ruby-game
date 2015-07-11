class Player
  attr_reader :score

  def initialize(x, y)
    @x, @y = x, y
    @image = MediaUtil::get_img("role/001.jpg")
    @beep = MediaUtil::get_sample("pickup.wav")
    @speed = 2.0
    @score = 0
    init_animations
    @direction = Direction::DOWN
    @move_timestamp = Gosu::milliseconds
    @standing = true
    @running = true
  end

  def init_animations
    anim_interval = 150

    h_walk_img_nums = [32, 31, 30, 31, 32, 33, 34, 33]
    @anim_walk_laft = get_animation(h_walk_img_nums, anim_interval)
    @anim_walk_right = get_animation(h_walk_img_nums, anim_interval, -1)

    up_walk_img_nums = [22, 21, 20, 21, 22, 23, 24, 23]
    @anim_walk_up = get_animation(up_walk_img_nums, anim_interval)

    down_walk_img_nums = [7, 6, 5, 6, 7, 8, 9, 8]
    @anim_walk_down = get_animation(down_walk_img_nums, anim_interval)


    h_stand_img_nums = [27, 26, 25, 26, 27, 28, 29, 28]
    @anim_stand_left = get_animation(h_stand_img_nums, anim_interval)
    @anim_stand_right = get_animation(h_stand_img_nums, anim_interval, -1)

    up_stand_img_nums = [17, 16, 15, 16, 17, 18, 19, 18]
    @anim_stand_up = get_animation(up_stand_img_nums, anim_interval)

    down_stand_img_nums = [2, 1, 0, 1, 2, 3, 4, 3]
    @anim_stand_down = get_animation(down_stand_img_nums, anim_interval)


    h_run_img_nums = [52, 51, 50, 51, 52, 53, 54, 53]
    @anim_run_left = get_animation(h_run_img_nums, anim_interval)
    @anim_run_right = get_animation(h_run_img_nums, anim_interval, -1)

    up_run_img_nums = [47, 46, 45, 46, 47, 48, 49, 48]
    @anim_run_up = get_animation(up_run_img_nums, anim_interval)

    down_run_img_nums = [42, 41, 40, 41, 42, 43, 44, 43]
    @anim_run_down = get_animation(down_run_img_nums, anim_interval)
  end

  private def get_animation(nums, interval, scale_x = 1, scale_y = 1)
    images = []
    nums.each do |num|
      images << get_img(num)
    end
    Animation.new(images, interval, scale_x, scale_y)
  end

  private def get_img(num)
    path = "role/wangye/WanGye_#{num}.bmp"
    MediaUtil::get_img(path)
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

  def move direction
    if direction != Direction::NONE
      @standing = false
      angle = Direction::to_angle direction

      speed = @running ? @speed * 2 : @speed

      @x += Gosu::offset_x(angle, speed)
      @y += Gosu::offset_y(angle, speed)
      @move_timestamp = Gosu::milliseconds
      @direction = direction
    else
      @standing = true
    end
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