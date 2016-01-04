class FoodViewModel < ItemViewModel
  attr_reader :food

  ENERGY_BAR_WIDTH = 40
  ENERGY_BAR_HEIGHT = 4

  def initialize(food)
    super food
    @food = food
    @image = MediaUtil::get_img(food.image_path)
  end

  def draw(auto_scale)
    update_scale y if auto_scale

    if @food.visible
      z_order = ZOrder::Player # @food.eating && !@food.covered ? ZOrder::Player : ZOrder::Food
      @image.draw_rot(@food.x, @food.y, z_order, 0, 0.5, 0.5, scale_value, scale_value)

      if @food.energy < @food.max_energy
        energy_bar_width = ENERGY_BAR_WIDTH * @food.energy / @food.max_energy
        Gosu::draw_rect @food.x-energy_bar_width/2, @food.y + 18 * scale_value,
                        energy_bar_width, ENERGY_BAR_HEIGHT, 0xFF_0090F7, z_order
      end
    end
  end

  def pick_up(player_vm)
    player_vm.start_eat_food(self)
  end
end