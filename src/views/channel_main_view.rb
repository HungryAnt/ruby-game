# coding: UTF-8

class ChannelMainView
  def initialize(window)
    @window = window
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
    # @target_map_id = nil
  end

  def init_channel_element
    @main_dialog = AntGui::Dialog.new(0, 0, GameConfig::MAP_WIDTH, GameConfig::MAP_HEIGHT)
    canvas = AntGui::Canvas.new
    @main_dialog.content = canvas

    control_seven_star_hall = create_back_channel_control canvas, 11, 12, 120, 50, 221, 238
    control_village = create_back_channel_control canvas, 1, 2, 0, 228, 370, 251

    control_seven_star_hall.on_mouse_left_button_down do
      @select_map_call_back.call :seven_star_hall
    end

    control_village.on_mouse_left_button_down do
      @select_map_call_back.call :house
    end

    @main_dialog.update_arrange
  end

  def create_back_channel_control(canvas, normal_image_num, hover_image_num, left, top, width, height)
    control_back = AntGui::Control.new
    control_back.content = AntGui::Image.new(MediaUtil.get_img(get_image_path(normal_image_num)))

    control_active = AntGui::Control.new
    hover_image = AntGui::Image.new(MediaUtil.get_img(get_image_path(hover_image_num)))
    control_active.on_mouse_enter {control_active.content = hover_image; control_active.refresh}
    control_active.on_mouse_leave {control_active.content = nil}

    AntGui::Canvas.set_canvas_props(control_back, left, top, width, height)
    AntGui::Canvas.set_canvas_props(control_active, left, top, width, height)

    canvas.add control_back
    canvas.add control_active

    control_active
  end

  def get_image_path(num)
    "channel_main/ChannelMain_#{num}.bmp"
  end

  def register_select_map(&call_back)
    @select_map_call_back = call_back
  end

  def update
    @main_dialog.mouse_move(@window.mouse_x, @window.mouse_y)

    # unless @target_map_id.nil?
    #   @select_map_call_back.call @target_map_id
    # end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @main_dialog.draw
    left, top, width, height = 0, GameConfig::MAP_HEIGHT, GameConfig::MAP_WIDTH, GameConfig::WHOLE_HEIGHT - GameConfig::MAP_HEIGHT
    color_0 = 0xFF_FEFEFE
    color_1 = 0xFF_DBDBDB
    Gosu::draw_triangle(left, top, color_0, left, top + height, color_1, left + width, top + height, color_1,
                        ZOrder::Background)
    Gosu::draw_triangle(left, top, color_0, left + width, top + height, color_1, left + width, top, color_0,
                        ZOrder::Background)


  end

  def button_down(id)
    case id
      when Gosu::MsLeft
        @main_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
    end
  end

  def button_up(id)

  end

  def needs_cursor?
    true
  end
end