class MouseType
  NORMAL = 0
  NORMAL_BUTTON_DOWN = 1
  PICK_UP = 2
  PICK_UP_BUTTON_DOWN = 3
  GOTO_AREA = 4
end

class MouseViewModel
  def initialize
    init_images
    @picture = nil
    @needs_sys_cursor = true

    @mouse_type = nil
    set_mouse_type MouseType::NORMAL
  end

  def set_mouse_type(mouse_type)
    if @mouse_type != mouse_type
      @mouse_type = mouse_type

      if @mouse_type == MouseType::GOTO_AREA
        @picture = AnimationManager.get_anim :goto_area
      else
        if @images_map.include? @mouse_type
          @picture = @images_map[@mouse_type]
        end
      end
    end
  end

  def draw(x, y)
    @picture.draw x, y, ZOrder::Mouse unless @picture.nil?
  end

  def needs_cursor?
    false
  end

  private
  def init_images
    @images_map = {}
    @images_map[MouseType::NORMAL] = get_image(0)
    @images_map[MouseType::NORMAL_BUTTON_DOWN] = get_image(1)
    @images_map[MouseType::PICK_UP] = get_image(2)
    @images_map[MouseType::PICK_UP_BUTTON_DOWN] = get_image(3)
  end

  def get_image(num)
    Image.new(MediaUtil.get_img("ui/cursor/#{num}.bmp"), 1, 5)
  end
end