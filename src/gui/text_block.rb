module AntGui
  class TextBlock < Control
    def initialize(font, text)
      super()
      @font, @text = font, text
    end

    def do_draw(z)
      super
    end
  end
end
