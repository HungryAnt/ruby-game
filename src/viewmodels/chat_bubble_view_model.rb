# coding: UTF-8
class ChatBubbleViewModel
  PADDING = 5
  TIP_WIDTH = 10
  TIP_HEIGHT = 7

  def initialize
    autowired(WindowResourceService)
    @lines = []
    @target = [0, 0]
    @font = @window_resource_service.get_chat_bubble_font
  end

  def set_content(content)
    @lines = StringUtil.split_lines content, 18 # 每行最多英文字符数量
  end

  def draw_with_target(x, y)
    return if @lines.nil? || @lines.length == 0
    width = TIP_WIDTH * 2
    height = 0
    @lines.each do |line|
      w = @font.text_width(line)
      width = [width, w].max
      height += @font.height
    end
    height = 10 if height < 10
    width += PADDING * 2
    height += PADDING * 2
    left = x - width/2
    top = y - height - TIP_HEIGHT
    Gosu::draw_rect(left, top, width, height, 0xA0_FFFFFF, ZOrder::DIALOG_UI)
    Gosu::draw_triangle(x, y, 0x60_FFFFFF,
                        x - TIP_WIDTH / 2, y - TIP_HEIGHT, 0xA0_FFFFFF,
                        x + TIP_WIDTH / 2, y - TIP_HEIGHT, 0xA0_FFFFFF)

    text_left = left + PADDING
    text_top = top + PADDING
    @lines.each do |line|
      @font.draw(line, text_left, text_top, ZOrder::DIALOG_UI, 1, 1, 0xFF_000000)
      text_top += @font.height
    end

  end
end