class NutrientViewModel < ItemViewModel
  attr_reader :nutrient

  def initialize(nutrient)
    super nutrient
    @nutrient = nutrient
    @image = MediaUtil::get_img(nutrient.image_path)
  end

  def nutrient_type_id
    @nutrient.nutrient_type_id
  end

  def draw(auto_scale)
    update_scale auto_scale, y
    @image.draw_rot(@nutrient.x, @nutrient.y, ZOrder::Player, 0, 0.5, 0.5, scale_value, scale_value)
  end

  def pick_up(player_vm)
    player_vm.collect_nutrient(self)
  end
end