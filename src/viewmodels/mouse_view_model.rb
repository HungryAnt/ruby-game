class MouseType
  NORMAL = 0
  PICK_UP = 1
  GOTO_AREA = 2
end

class MouseViewModel
  def initialize
    @picture = nil
    @needs_sys_cursor = true

    @mouse_type = nil
    set_mouse_type MouseType::NORMAL
  end

  def set_mouse_type(mouse_type)
    if @mouse_type != mouse_type
      @mouse_type = mouse_type

      if @mouse_type == MouseType::NORMAL
        @picture = nil
        @needs_sys_cursor = true
      elsif @mouse_type == MouseType::PICK_UP
        @picture = nil
        @needs_sys_cursor = true
      elsif @mouse_type == MouseType::GOTO_AREA
        @picture = AnimationManager.get_anim :goto_area
        @needs_sys_cursor = false
      end
    end
  end

  def draw(x, y)
    @picture.draw x, y, ZOrder::Mouse unless @picture.nil?
  end

  def needs_cursor?
    @needs_sys_cursor
  end
end