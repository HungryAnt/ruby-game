module MouseTips

  def draw_mouse_tips(mouse_x, mouse_y, offset_x=26, offset_y=23)
    return if @mouse_tips_text.nil?
    @text_block.text = @mouse_tips_text
    text_size = @text_block.messure_text_size
    AntGui::Canvas.set_canvas_props(@text_block, 0, 0, *text_size)
    @tips_canvas.arrange(mouse_x + offset_x, mouse_y + offset_y, *text_size)
    @tips_canvas.draw
  end

  private

  def init_mouse_tips
    @mouse_tips_text = nil
    tips_font = @window_resource_service.get_normal_font
    @text_block = AntGui::TextBlock.new tips_font, ''
    @text_block.background_color = 0x88_000000
    @text_block.foreground_color = 0xEE_FFBF35

    @tips_canvas = AntGui::Canvas.new {
      [@text_block,]
    }
  end

  def set_tips_text(text)
    @mouse_tips_text = text
  end
end