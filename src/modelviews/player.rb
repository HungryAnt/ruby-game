class Player
  attr_reader :score

  def initialize(x, y)
    @x, @y = x, y
    @image = MediaUtil::get_img("role/001.jpg")
    @beep = MediaUtil::get_sample("beep.wav")
    @speed = 5.0
    @score = 0
  end

  def draw
    @image.draw_rot(@x, @y, ZOrder::Player, 0)
  end

  def move direction
    if direction != Control::Direction::NONE
      angle = Control::Direction::to_angle direction
      @x += Gosu::offset_x(angle, @speed)
      @y += Gosu::offset_y(angle, @speed)
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