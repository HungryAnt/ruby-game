module AntGui
  class TextBlock < Control
    attr_accessor :text, :foreground_color

    def initialize(font, text, hor_align=:left, ver_align=:center)
      super()
      @font, @text = font, text
      @foreground_color = 0xFF_000000
      @hor_align, @ver_align = hor_align, ver_align
    end

    def do_draw(z)
      super
      if @hor_align == :left
        left = @actual_left
        rel_x = 0.0
      elsif @hor_align == :center
        left = @actual_left + @actual_width / 2
        rel_x = 0.5
      else
        left = @actual_left + @actual_width
        rel_x = 1.0
      end

      if @ver_align == :top
        top = @actual_top
        rel_y = 0.0
      elsif @ver_align == :center
        top = @actual_top + @actual_height / 2
        rel_y = 0.5
      else
        top = @actual_top + @actual_height
        rel_y = 1.0
      end

      @font.draw_rel(@text, left, top, z, rel_x, rel_y, 1.0, 1.0, @foreground_color)
    end
  end
end
