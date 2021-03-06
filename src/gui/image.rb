module AntGui
  class Image < Visual
    def initialize(gosu_img)
      super()
      @gosu_img = gosu_img
    end

    def do_draw(z)
      @gosu_img.draw(@actual_left, @actual_top, z,
                     @actual_width * 1.0 / @gosu_img.width, @actual_height * 1.0 / @gosu_img.height,
                     0xff_ffffff, mode = :default)
    end
  end
end