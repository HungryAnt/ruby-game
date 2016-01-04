class RubbishViewModel < ItemViewModel
  attr_reader :rubbish

  def initialize(rubbish)
    super rubbish
    @rubbish = rubbish
    @image = MediaUtil::get_img(rubbish.image_path)
  end

  def rubbish_type_id
    @rubbish.rubbish_type_id
  end

  def draw(auto_scale)
    update_scale y if auto_scale
    @image.draw_rot(@rubbish.x, @rubbish.y, ZOrder::Player, 0, 0.5, 0.5, scale_value, scale_value)
  end

  def pick_up(player_vm)
    player_vm.collect_rubbish(self)
  end
end