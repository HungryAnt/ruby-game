module AutoScaleModule
  def init_auto_scale
    @scale = 1.0
  end

  def scale_value
    @scale
  end

  def update_scale(y)
    @scale = 0.35 + 0.75 * y / GameConfig::MAP_HEIGHT
  end
end