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

  def draw
    @image.draw_rot(@nutrient.x, @nutrient.y, ZOrder::Player, 0)
  end

  def pick_up(player_vm)
    player_vm.collect_nutrient(self)
  end
end