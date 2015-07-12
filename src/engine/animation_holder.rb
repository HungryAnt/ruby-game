class AnimationHolder
  def initialize(anim, x, y, z,
                 loop_forever = true, loop_count = 1)
    @anim, @x, @y, @z = anim, x, y, z
    @loop_forever = loop_forever
    unless loop_forever
      @duraion = anim.interval * anim.img_count * loop_count
      @start_timestamp = Gosu::milliseconds
    end
  end

  def draw
    @anim.draw @x, @y, @z
  end

  def finish?
    return false if @loop_forever
    Gosu::milliseconds > @start_timestamp + @duraion
  end
end