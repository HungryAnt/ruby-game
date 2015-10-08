class MultiItemsControl < AntGui::Control
  def initialize(image, count)
    super()
    autowired(WindowResourceService)
    @image = image
    @count = count
    @font = @window_resource_service.get_normal_font
  end

  def do_draw(z)
    super
    if @image.width > @actual_width || @image.height > @actual_height
      left, top = @actual_left, @actual_top
      scale_x = @actual_width * 1.0 / @image.width
      scale_y = @actual_height * 1.0 / @image.height
    else
      left = @actual_left + (@actual_width - @image.width)/2
      top = @actual_top + (@actual_height - @image.height)/2
      scale_x = scale_y = 1
    end
    @image.draw(left, top, z, scale_x, scale_y, 0xff_ffffff, mode = :default)
    @font.draw_rel("#{@count}", @actual_left + @actual_width, @actual_top + @actual_height,
                   z, 1.0, 1.0, 1.0, 1.0, 0xBB_ffffff)
  end
end