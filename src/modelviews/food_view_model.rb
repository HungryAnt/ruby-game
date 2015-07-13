class FoodViewModel
  attr_reader :food

  def initialize(food)
    @food = food
    @image = MediaUtil::get_img("food/001.bmp")
  end

  def draw
    @image.draw_rot(@food.x, @food.y, ZOrder::Food, 0)
  end
end