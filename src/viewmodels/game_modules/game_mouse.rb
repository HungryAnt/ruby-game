# coding: UTF-8

module GameMouse
  include MouseTips

  def init_mouse
    @mouse_vm = MouseViewModel.new
    init_mouse_tips
  end

  def draw_mouse(mouse_x, mouse_y)
    @mouse_vm.draw mouse_x, mouse_y
    draw_mouse_tips mouse_x, mouse_y
  end

  def update_mouse_type(mouse_x, mouse_y)
    set_tips_text nil

    map_vm = get_current_map
    mouse_left_down = Gosu::button_down?(Gosu::MsLeft)
    if map_vm.gateway? mouse_x, mouse_y
      @mouse_vm.set_mouse_type MouseType::GOTO_AREA
      set_tips_text '前往'
      return
    end

    if !@player_view_model.battered

      touch_item = get_touch_item(mouse_x, mouse_y, get_item_vms)
      unless touch_item.nil?
        set_tips_text "#{touch_item.name}"
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::PICK_UP_BUTTON_DOWN : MouseType::PICK_UP)
        return
      end

      touch_large_rubbish = get_touch_rubbish(mouse_x, mouse_y)
      unless touch_large_rubbish.nil?
        set_tips_text "#{touch_large_rubbish.name}"
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::SMASH_BUTTON_DOWN : MouseType::SMASH)
        return
      end
    end

    @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::NORMAL_BUTTON_DOWN : MouseType::NORMAL)
  end
end