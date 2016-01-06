module AutoScaleModule
  def init_auto_scale
    @scale = 1.0
  end

  def scale_value
    @scale
  end

  def update_scale(auto_scale_info, y)
    if auto_scale_info[:auto_scale]
      @scale = 0.35 + 0.75 * y / auto_scale_info[:area_height]
    else
      @scale = 1.0
    end
  end
end