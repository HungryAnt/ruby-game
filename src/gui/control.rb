module AntGui
  class Control < Visual
    attr_accessor :content, :background_color

    def initialize
      super
      @content = nil
      @background_color = nil # 0x00_FFFFFF
    end

    def arrange(left, top, width, height)
      super
      @content.arrange left, top, width, height unless @content.nil?
    end

    def refresh
      arrange @actual_left, @actual_top, @actual_width, @actual_height
    end

    def do_draw(z)
      unless @background_color.nil?
        Gosu::draw_rect(@actual_left, @actual_top, @actual_width, @actual_height, @background_color, z)
      end
      @content.draw z unless @content.nil?
    end

    def mouse_left_button_down(x, y)
      unless @content.nil?
        return true if @content.mouse_left_button_down(x, y)
      end
      super
    end

  end
end