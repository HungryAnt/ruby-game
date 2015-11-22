class AreaVisualElementViewModel
  attr_reader :y

  def initialize(element)
    @element = element
    @image = nil
    @image = MediaUtil::get_tileable_img(element.image_path) unless element.image_path.nil?
    @animation = nil
    @animation = AnimationManager.get_anim(element.anim_key) unless element.anim_key.nil?
    @y = element.y
  end

  def draw
    @image.draw(@element.left, @element.top, ZOrder::Player) unless @image.nil?
    @animation.draw(@element.left, @element.top, ZOrder::Player) unless @animation.nil?
  end
end