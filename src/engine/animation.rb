class Animation
  def initialize images, interval, scale_x = 1, scale_y = 1
    raise ArgumentError "nil images" if images.nil?
    raise ArgumentError "wrong interval #{interval}" if interval <= 0
    @images = images
    @interval = interval
    @scale_x = scale_x
    @scale_y = scale_y
  end

  def draw x, y, z
    return if @images.size == 0
    img = @images[Gosu::milliseconds / @interval % @images.size]
    img.draw_rot(x, y, z, 0, 0.5, 0.5, @scale_x, @scale_y)
  end
end