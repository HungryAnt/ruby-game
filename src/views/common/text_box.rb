class TextBox
  attr_accessor :enabled, :font
  attr_reader :text_input

  def initialize(enabled)
    @font = Gosu::Font.new(18)
    @enabled = enabled
    @text_input = Gosu::TextInput.new
  end

  def draw(left, top, width, height)
    color = @enabled ? 0xFF_F8F8F8: 0xFF_A07028
    Gosu::draw_rect left, top, width, height, color, ZOrder::Background
    text = @text_input.text
    text_width = @font.text_width(text, 1)

    if text_width < width
      text_offset_x = 0
    else
      text_offset_x = width - text_width
    end
    text_x = left + text_offset_x

    @font.draw_rel("#{text}", text_x , top + height/2,
                   ZOrder::Background, 0, 0.5, 1.0, 1.0, 0xff_000000)
  end

  def text
    @text_input.text
  end

  def clear
    @text_input.text = ''
  end
end