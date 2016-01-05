module AutoScaleModule
  def init_auto_scale
    @scale = 1.0
  end

  def scale_value
    @scale
  end

  def update_scale(auto_scale, y)
    if auto_scale
      @scale = 0.35 + 0.75 * y / GameConfig::MAP_HEIGHT
    else
      @scale = 1.0
    end
  end
end