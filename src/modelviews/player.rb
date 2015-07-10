class Player
  def initialize(x, y)
    @x, @y = x, y
    @image = Gosu::Image.new("media/img/role/001.jpg")
  end

  def draw
    @image.draw_rot(@x, @y, ZOrder::Player, 0)
  end
end