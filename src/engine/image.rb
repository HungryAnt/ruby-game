class Image
  def initialize(image, center_x, center_y)
    @image, @center_x, @center_y = image, center_x, center_y
  end

  def draw(x, y, z)
    @image.draw(x - @center_x, y - @center_y, z)
  end
end