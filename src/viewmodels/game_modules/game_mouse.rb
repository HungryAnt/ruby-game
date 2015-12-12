# coding: UTF-8

module GameMouse
  def init_mouse
    @mouse_vm = MouseViewModel.new
    init_mouse_tips_ui
  end

  def draw_mouse(mouse_x, mouse_y)
    @mouse_vm.draw mouse_x, mouse_y
    draw_mouse_tips mouse_x, mouse_y
  end

  def update_mouse_type(mouse_x, mouse_y)
    @mouse_tips_text = nil

    map_vm = get_current_map
    mouse_left_down = Gosu::button_down?(Gosu::MsLeft)
    if map_vm.gateway? mouse_x, mouse_y
      @mouse_vm.set_mouse_type MouseType::GOTO_AREA
      @mouse_tips_text = '前往'
      return
    end

    if !@player_view_model.battered

      touch_item = get_touch_item(mouse_x, mouse_y, get_item_vms)
      unless touch_item.nil?
        @mouse_tips_text = "#{touch_item.name}"
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::PICK_UP_BUTTON_DOWN : MouseType::PICK_UP)
        return
      end

      touch_large_rubbish = get_touch_rubbish(mouse_x, mouse_y)
      unless touch_large_rubbish.nil?
        @mouse_tips_text = "#{touch_large_rubbish.name}"
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::SMASH_BUTTON_DOWN : MouseType::SMASH)
        return
      end
    end

    @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::NORMAL_BUTTON_DOWN : MouseType::NORMAL)
  end

  private

  def init_mouse_tips_ui
    @mouse_tips_text = nil
    tips_font = @window_resource_service.get_normal_font
    @text_block = AntGui::TextBlock.new tips_font, ''
    @text_block.background_color = 0x88_000000
    @text_block.foreground_color = 0xEE_FFBF35

    @tips_canvas = AntGui::Canvas.new {
      [@text_block,]
    }
  end

  def draw_mouse_tips(mouse_x, mouse_y)
    return if @mouse_tips_text.nil?
    @text_block.text = @mouse_tips_text
    text_size = @text_block.messure_text_size
    AntGui::Canvas.set_canvas_props(@text_block, 0, 0, *text_size)
    @tips_canvas.arrange(mouse_x + 26, mouse_y + 23, *text_size)
    @tips_canvas.draw
  end
end