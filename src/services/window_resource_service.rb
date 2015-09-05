# coding: UTF-8
class WindowResourceService
  def init(window)
    @window = window
    @font_chat_bubble = Gosu::Font.new(window, 'Verdana', 17)
  end

  def get_chat_bubble_font
    @font_chat_bubble
  end
end