module AntGui
  class Control < Visual
    attr_accessor :content, :background_color

    def initialize
      super
      @content = nil
      @background_color = nil # 0x00_FFFFFF
      @mouse_left_button_down_proc = nil
      @mouse_in_area = false
      @mouse_enter_proc = @mouse_leave_proc = nil
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

    def refresh
      arrange @actual_left, @actual_top, @actual_width, @actual_height
    end

    def draw
      unless @background_color.nil?
        Gosu::draw_rect(@actual_left, @actual_top, @actual_width, @actual_height, @background_color, ZOrder::DIALOG_UI)
      end
      @content.draw unless @content.nil?
    end

    def on_mouse_left_button_down(&proc)
      if block_given?
        @mouse_left_button_down_proc = proc
      end
    end

    def mouse_left_button_down(x, y)
      unless @content.nil?
        return true if @content.mouse_left_button_down(x, y)
      end

      if contains_point?(x, y)
        call_mouse_left_button_down_proc
        return true
      end
      false
    end

    def on_mouse_enter(&proc)
      if block_given?
        @mouse_enter_proc = proc
      end
    end

    def on_mouse_leave(&proc)
      if block_given?
        @mouse_leave_proc = proc
      end
    end

    def mouse_move(x, y)
      is_mouse_in = contains_point?(x, y)
      if @mouse_in_area && !is_mouse_in
        @mouse_leave_proc.call unless @mouse_leave_proc.nil?
      elsif !@mouse_in_area && is_mouse_in
        @mouse_enter_proc.call unless @mouse_enter_proc.nil?
      end
      @mouse_in_area = is_mouse_in
    end

    private
    def call_mouse_left_button_down_proc
      @mouse_left_button_down_proc.call unless @mouse_left_button_down_proc.nil?
    end
  end
end