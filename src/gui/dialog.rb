module AntGui
  class Dialog < Container
    attr_accessor :active

    def initialize(left, top, width, height)
      super()
      @left, @top, @width, @height = left, top, width, height
      arrange(left, top, width, height)
      @mouse_x = @mouse_y = 0
      @active = true
    end

    def update_arrange
      @content.arrange(@left, @top, @width, @height) unless @content.nil?
    end

    def mouse_move(x, y)
      return unless @active
      return if x == @mouse_x && y == @mouse_y
      @content.mouse_move(x, y) unless @content.nil?
      super
    end
  end
end
