class Ground
  def initialize(view_width, view_height)
    @image = MediaUtil::get_tileable_img('ground/001.jpg')
    @scale_x = view_width * 1.0 / @image.width
    @scale_y = view_height * 1.0 / @image.height
  end

  def draw
    @image.draw(0, 0, ZOrder::Background, @scale_x, @scale_y)
  end
end