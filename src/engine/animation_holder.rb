class AnimationHolder
  def initialize(anim, x, y, z,
                 loop_forever = true, loop_count = 1)
    @anim, @x, @y, @z = anim, x, y, z
    @loop_forever = loop_forever
    unless loop_forever
      @duraion = interval *images.size * loop_count
      @start_timestamp = Guso::milliseconds
    end
  end

  def draw
    @anim.draw @x, @y, @z
  end

  def finish?
    return false if @loop_forever
    Guso::milliseconds > @start_timestamp + @duraion
  end
end