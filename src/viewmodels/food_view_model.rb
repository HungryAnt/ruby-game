class FoodViewModel < ItemViewModel
  attr_reader :food

  ENERGY_BAR_WIDTH = 40

  def initialize(food)
    super food
    @food = food
    @image = MediaUtil::get_img(food.image_path)
  end

  def draw
    if @food.visible
      z_order = @food.eating && !@food.covered ? ZOrder::Player : ZOrder::Food
      @image.draw_rot(@food.x, @food.y, z_order, 0)

      if @food.energy < @food.max_energy
        energy_bar_width = ENERGY_BAR_WIDTH * @food.energy / @food.max_energy
        Gosu::draw_rect @food.x-energy_bar_width/2, @food.y+18,
                        energy_bar_width, 4, 0xFF_0090F7
      end
    end
  end
end