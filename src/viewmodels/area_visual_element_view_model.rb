class AreaVisualElementViewModel
  attr_reader :y

  def initialize(element)
    @element = element
    @image = MediaUtil::get_tileable_img(element.image_path)
    @y = element.y
  end

  def draw
    @image.draw(@element.left, @element.top, ZOrder::Player)
  end
end