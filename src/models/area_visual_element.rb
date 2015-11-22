class AreaVisualElement
  attr_reader :image_path, :anim_key, :left, :top, :y

  def initialize(image_path, anim_key, left, top, y)
    @image_path = image_path
    @anim_key = anim_key
    @left, @top = left, top
    @y = y
  end
end