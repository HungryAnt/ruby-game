module AntGui
  class Animation < Visual
    def initialize(anim)
      super()
      @anim = anim
    end

    def do_draw(z)
      @anim.draw @actual_left, @actual_top, z
    end
  end
end
