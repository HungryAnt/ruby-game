class AreaVisualElement
  attr_reader :image_path, :left, :top, :y

  def initialize(image_path, left, top, y)
    @image_path = image_path
    @left, @top = left, top
    @y = y
  end
end