class Animation
  attr_reader :interval

  def initialize(images, interval, offset=[0, 0])
    raise ArgumentError "nil images" if images.nil?
    raise ArgumentError "wrong interval #{interval}" if interval <= 0
    @images = images
    @interval = interval
    goto_begin
    @offset_x, @offset_y = offset[0], offset[1]
  end

  # def with_offset(offset_x, offset_y)
  #   @offset_x, @offset_y = offset_x, offset_y
  #   self
  # end

  def img_count
    @images.size
  end

  def goto_begin
    @init_timestamp = Gosu::milliseconds
  end

  def draw(x, y, z)
    return if @images.size == 0
    img = @images[(Gosu::milliseconds - @init_timestamp) / @interval % @images.size]
    img.draw(x + @offset_x, y + @offset_y, z)
  end
end