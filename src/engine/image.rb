class Image
  def initialize(image, center_x = 0, center_y = 0)
    @image, @center_x, @center_y = image, center_x, center_y
  end

  def draw(x, y, z, options={})
    mode = options.include?(:mode) ? options[:mode] : :default
    @image.draw(x - @center_x, y - @center_y, z, 1, 1, 0xFF_FFFFFF, mode)
  end
end

class CenteredImage
  def initialize(image, scale_x, scale_y)
    @image, @scale_x, @scale_y = image, scale_x, scale_y
  end

  def draw(x, y, z, options={})
    mode = options.include?(:mode) ? options[:mode] : :default
    color = options.include?(:color) ? options[:color] : 0xFF_FFFFFF
    @image.draw_rot(x, y, z, 0, 0.5, 0.5, @scale_x, @scale_y, color, mode)
  end
end