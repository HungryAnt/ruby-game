class Image
  def initialize(image, center_x = 0, center_y = 0)
    @image, @center_x, @center_y = image, center_x, center_y
  end

  def draw(x, y, z)
    @image.draw(x - @center_x, y - @center_y, z)
  end
end

class CenteredImage
  def initialize(image, scale_x, scale_y)
    @image, @scale_x, @scale_y = image, scale_x, scale_y
  end

  def draw(x, y, z)
    @image.draw_rot(x, y, z, 0, 0.5, 0.5, @scale_x, @scale_y)
  end
end