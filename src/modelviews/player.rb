class Player
  attr_reader :score

  def initialize(x, y)
    @x, @y = x, y
    @image = MediaUtil::get_img("role/001.jpg")
    @beep = MediaUtil::get_sample("eat.wav")
    @speed = 2.0
    @score = 0
    init_animations
    @direction = Direction::DOWN
  end

  def init_animations
    h_walk_img_nums = [32, 31, 30, 31, 32, 33, 34, 33]
    @anim_walk_laft = get_animation(h_walk_img_nums, 200)
    @anim_walk_right = get_animation(h_walk_img_nums, 200, -1)

    up_walk_img_nums = [22, 21, 20, 21, 22, 23, 24, 23]
    @anim_walk_up = get_animation(up_walk_img_nums, 200)

    down_walk_img_nums = [7, 6, 5, 6, 7, 8, 9, 8]
    @anim_walk_down = get_animation(down_walk_img_nums, 200)
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
    anim = @anim_walk_down
    if @direction & Direction::LEFT == Direction::LEFT
      anim = @anim_walk_laft
    elsif @direction & Direction::RIGHT == Direction::RIGHT
      anim = @anim_walk_right
    elsif @direction & Direction::UP == Direction::UP
      anim = @anim_walk_up
    elsif @direction & Direction::DOWN == Direction::DOWN
      anim = @anim_walk_down
    end
    anim.draw(@x, @y, ZOrder::Player)
  end

  def move direction
    if direction != Direction::NONE
      angle = Direction::to_angle direction
      @x += Gosu::offset_x(angle, @speed)
      @y += Gosu::offset_y(angle, @speed)
      @direction = direction
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