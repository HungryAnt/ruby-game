class FoodViewModel
  attr_reader :food

  def initialize(food)
    @food = food
    @image = MediaUtil::get_img("food/001.bmp")
  end

  def draw
    if @food.visible
      z_order = @food.eating && !@food.covered ? ZOrder::Player : ZOrder::Food
      @image.draw_rot(@food.x, @food.y, z_order, 0)
    end
  end
end