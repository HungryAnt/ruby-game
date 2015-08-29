module AntGui
  class Dialog < Container
    def initialize(left, top, width, height)
      super()
      @left, @top, @width, @height = left, top, width, height
      arrange(left, top, width, height)
    end

    def update_arrange
      @content.arrange( @left, @top, @width, @height) unless @content.nil?
    end
  end
end
