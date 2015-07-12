class FoodViewModel
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
    @image = MediaUtil::get_img("food/001.bmp")
  end

  def draw
    @image.draw_rot(@x, @y, ZOrder::Food, 0)
  end
end