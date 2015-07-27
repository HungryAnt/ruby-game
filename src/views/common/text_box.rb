class TextBox
  attr_accessor :enabled, :font, :default_text
  attr_reader :text_input

  def initialize(enabled)
    @font = Gosu::Font.new(18)
    @enabled = enabled
    @text_input = Gosu::TextInput.new
    @default_text = ''
  end

  def draw(left, top, width, height)
    color = @enabled ? 0xFF_F8F8F8: 0xFF_A07028
    Gosu::draw_rect left, top, width, height, color, ZOrder::Background
    text = @text_input.text
    show_default_text = text == ''
    text = @default_text if show_default_text
    text_width = @font.text_width(text, 1)
    if text_width < width
      text_offset_x = 0
    else
      text_offset_x = width - text_width
    end
    text_x = left + text_offset_x

    @font.draw_rel("#{text}", text_x , top + height/2,
                   ZOrder::Background, 0, 0.5, 1.0, 1.0, show_default_text ? 0xFF_444444 : 0xFF_000000)
  end

  def text
    @text_input.text
  end

  def clear
    @text_input.text = ''
  end
end