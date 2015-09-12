module AntGui
  class TextBlock < Control
    attr_accessor :text, :foreground_color

    def initialize(font, text)
      super()
      @font, @text = font, text
      @foreground_color = 0xFF_000000
    end

    def do_draw(z)
      super
      @font.draw_rel(@text, @actual_left, @actual_top + @actual_height / 2,
                     z, 0, 0.5, 1.0, 1.0, @foreground_color)
    end
  end
end
