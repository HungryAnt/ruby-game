class AnimationHolder
  def initialize(anim, x, y, z,
                 loop_forever = true, loop_count = 1)
    @anim, @x, @y, @z = anim, x, y, z
    @loop_forever = loop_forever
    @start_timestamp = Gosu::milliseconds
    unless loop_forever
      @duraion = anim.interval * anim.img_count * loop_count
    end
  end

  def draw(options={})
    unless options.include? :init_timestamp
      options = options.clone
      options[:init_timestamp] = @start_timestamp
    end
    @anim.draw @x, @y, @z, options
  end

  def finish?
    return false if @loop_forever
    Gosu::milliseconds > @start_timestamp + @duraion
  end
end