module AntGui
  class Visual
    attr_accessor :actual_left, :actual_top, :actual_width, :actual_height

    def initialize
      @actual_left, @actual_top, @actual_width, @actual_height = 0, 0, 0, 0
    end

    def measure
      expected_width = 0
      expected_height = 0
      return expected_width, expected_height
    end

    def arrange(left, top, width, height)
      @actual_left, @actual_top, @actual_width, @actual_height = left, top, width, height
    end
  end
end
