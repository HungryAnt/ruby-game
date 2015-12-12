class GraphicsUtil
  def self.draw_rect_border(x, y, width, height, c, z = 0, mode = :default)
    Gosu::draw_line(x, y, c, x+width, y, c, z, mode)
    Gosu::draw_line(x+width, y, c, x+width, y+height, c, z, mode)
    Gosu::draw_line(x+width, y+height, c, x, y+height, c, z, mode)
    Gosu::draw_line(x, y+height, c, x, y, c, z, mode)
  end

  def self.draw_linear_rect(left, top, width, height, z, c0, c1, options={})
    if options.include?(:direction) && options[:direction] == 'hor'
      Gosu::draw_triangle(left, top, c0, left, top + height, c0, left + width, top + height, c1, z)
      Gosu::draw_triangle(left, top, c0, left + width, top + height, c1, left + width, top, c1, z)
    else
      Gosu::draw_triangle(left, top, c0, left, top + height, c1, left + width, top + height, c1, z)
      Gosu::draw_triangle(left, top, c0, left + width, top + height, c1, left + width, top, c0, z)
    end
  end

  def self.draw_text_with_border(text, font, x, y, z, scale_x, scale_y, color, border_color)
    font.draw(text, x, y-1, z, scale_x, scale_y, border_color)
    font.draw(text, x, y+1, z, scale_x, scale_y, border_color)
    font.draw(text, x-1, y, z, scale_x, scale_y, border_color)
    font.draw(text, x+1, y, z, scale_x, scale_y, border_color)
    font.draw(text, x, y, z, scale_x, scale_y, color)
  end

  def self.pt_in_rect?(x, y, left, top, width, height)
    x >= left && x < left + width && y >= top && y < top + height
  end
end