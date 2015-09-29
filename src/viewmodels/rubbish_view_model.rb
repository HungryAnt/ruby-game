class RubbishViewModel < ItemViewModel
  attr_reader :rubbish

  def initialize(rubbish)
    super rubbish
    @rubbish = rubbish
    @image = MediaUtil::get_img(rubbish.image_path)
  end

  def draw
    @image.draw_rot(@rubbish.x, @rubbish.y, ZOrder::RUBBISH, 0)
  end

  def pick_up(player_vm)
    player_vm.collect_rubbish(self)
  end
end