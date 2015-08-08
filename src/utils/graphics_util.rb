class GraphicsUtil
  def self.draw_rect_border(x, y, width, height, c, z = 0, mode = :default)
    Gosu::draw_line(x, y, c, x+width, y, c, z, mode)
    Gosu::draw_line(x+width, y, c, x+width, y+height, c, z, mode)
    Gosu::draw_line(x+width, y+height, c, x, y+height, c, z, mode)
    Gosu::draw_line(x, y+height, c, x, y, c, z, mode)
  end
end