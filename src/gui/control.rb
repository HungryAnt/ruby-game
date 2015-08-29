module AntGui
  class Control < Visual
    attr_accessor :content, :background_color

    def initialize
      super
      @content = nil
      @background_color = nil # 0x00_FFFFFF
      @button_down_proc = nil
    end

    def set(property, value)
      instance_variable_set("@#{property.to_s}", value)
    end

    def get(property)
      instance_variable_get("@#{property.to_s}")
    end

    def arrange(left, top, width, height)
      super
      @content.arrange left, top, width, height unless @content.nil?
    end

    def draw
      unless @background_color.nil?
        Gosu::draw_rect(@actual_left, @actual_top, @actual_width, @actual_height, @background_color, ZOrder::DIALOG_UI)
      end
      @content.draw unless @content.nil?
    end

    def on_button_down(&proc)
      if block_given?
        @button_down_proc = proc
      end
    end
  end
end