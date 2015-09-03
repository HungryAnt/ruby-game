# coding: UTF-8
class ChatBubbleViewModel
  PADDING = 5
  TIP_WIDTH = 10
  TIP_HEIGHT = 7
  TIME_OUT = 5

  def initialize
    autowired(WindowResourceService)
    @lines = []
    @target = [0, 0]
    @font = @window_resource_service.get_chat_bubble_font
    @content_with_timestamp_list = []
    @mutex = Mutex.new
  end

  def add_content(content)
    @mutex.synchronize {
      @content_with_timestamp_list << [content, Time.now.to_i]
    }
    refresh
  end

  def update_content
    return if @content_with_timestamp_list.length == 0
    disappear_time_in_s = Time.now.to_i - TIME_OUT
    need_refresh = false
    @mutex.synchronize {
      @content_with_timestamp_list.delete_if do |e|
        r = e[1] < disappear_time_in_s
        need_refresh = true if r
        r
      end
    }
    refresh if need_refresh
  end

  def draw_with_target(x, y)
    return if @lines.nil? || @lines.length == 0
    width = TIP_WIDTH * 2
    height = 0
    @lines.each do |line|
      puts line
      w = @font.text_width(line)
      width = [width, w].max
      height += @font.height
    end
    height = 10 if height < 10
    width += PADDING * 2
    height += PADDING * 2
    left = x - width/2
    top = y - height - TIP_HEIGHT
    bubble_color = 0xBB_FFFFFF
    Gosu::draw_rect(left, top, width, height, bubble_color, ZOrder::CHAT_BUBBLE)
    Gosu::draw_triangle(x, y, 0x60_FFFFFF,
                        x - TIP_WIDTH / 2, y - TIP_HEIGHT, bubble_color,
                        x + TIP_WIDTH / 2, y - TIP_HEIGHT, bubble_color)

    text_left = left + PADDING
    text_top = top + PADDING
    @lines.each do |line|
      @font.draw(line, text_left, text_top, ZOrder::CHAT_BUBBLE, 1, 1, 0xFF_000000)
      text_top += @font.height
    end
  end

  private

  def refresh
    all_content = ''
    @mutex.synchronize {
      all_content = (@content_with_timestamp_list.map {|e| e[0]}).join("\n")
    }
    @lines = StringUtil.split_lines all_content, 18 # 每行最多英文字符数量
  end
end