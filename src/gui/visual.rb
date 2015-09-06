module AntGui
  class Visual
    attr_accessor :actual_left, :actual_top, :actual_width, :actual_height, :visible

    def initialize
      @actual_left, @actual_top, @actual_width, @actual_height = 0, 0, 0, 0
      @visible = true
      @mouse_left_button_down_proc = nil
      @mouse_in_area = false
      @mouse_enter_proc = @mouse_leave_proc = nil
    end

    def draw
      do_draw if @visible
    end

    def do_draw

    end

    def set(property, value)
      instance_variable_set("@#{property.to_s}", value)
    end

    def get(property)
      instance_variable_get("@#{property.to_s}")
    end

    def measure
      expected_width = 0
      expected_height = 0
      return expected_width, expected_height
    end

    def arrange(left, top, width, height)
      @actual_left, @actual_top, @actual_width, @actual_height = left, top, width, height
    end

    def contains_point?(x, y)
      @actual_left <= x && @actual_left + @actual_width > x && @actual_top <= y && @actual_top + @actual_height > y
    end

    def on_mouse_left_button_down(&proc)
      if block_given?
        @mouse_left_button_down_proc = proc
      end
    end

    def mouse_left_button_down(x, y)
      if contains_point?(x, y) && !@mouse_left_button_down_proc.nil?
        @mouse_left_button_down_proc.call
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
  end
end
