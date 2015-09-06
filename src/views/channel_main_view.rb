# coding: UTF-8

class ChannelMainView
  def initialize(window)
    @window = window
    init_channel_anims
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
    # @target_map_id = nil
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def init_channel_anims
    @anim_container = AnimationContainer.new
    create_anim :channel_main_vegetable, 340, 320, ZOrder::DIALOG_UI
    create_anim :channel_main_cows, 200, 276
    create_anim :channel_main_sky_wheel, 620, 50
  end

  def create_anim(key, x, y, z=ZOrder::Background)
    anim = AnimationManager::get_anim key
    anim_holder = AnimationHolder.new(anim, x, y, z)
    @anim_container << anim_holder
  end

  def init_channel_element
    @main_dialog = AntGui::Dialog.new(0, 0, GameConfig::MAP_WIDTH, GameConfig::MAP_HEIGHT)
    canvas = AntGui::Canvas.new
    @main_dialog.content = canvas

    control_rubbish_station = create_channel_control(canvas, 7, 8, 276, 160, 138, 125,
                                                     28, 5, 5, 5)
    control_rubbish_station.on_mouse_left_button_down do
      # 修建中
    end

    control_seven_star_hall = create_channel_control(canvas, 11, 12, 120, 50, 221, 238,
                                                     35, 31, 31, 5)
    control_seven_star_hall.on_mouse_left_button_down do
      @select_map_call_back.call :seven_star_hall
    end

    control_village = create_channel_control(canvas, 1, 2, 0, 228, 370, 251,
                                             0, 59, 150, 29)
    control_village.on_mouse_left_button_down do
      @select_map_call_back.call :house
    end

    control_police_station = create_channel_control canvas, 13, 14, 430, 160, 103, 79
    control_police_station.on_mouse_left_button_down do
      @select_map_call_back.call :police
    end

    control_playground = create_channel_control(canvas, 3, 4, 430, 100, 370, 229,
                                                86, 50, 0, 44)
    control_playground.on_mouse_left_button_down do
      # 修建中
    end

    control_shop = create_channel_control(canvas, 5, 6, 334, 260, 372, 180,
                                          125, 28, 46, 22)
    control_shop.on_mouse_left_button_down do
      @select_map_call_back.call :pay
    end


    exit_button = AntGui::Facade.create_image_button(get_button_image_path(0), get_button_image_path(1))
    exit_button.on_mouse_left_button_down {@exit_call_back.call}
    exit_button.z_order = ZOrder::DIALOG_UI
    AntGui::Canvas.set_canvas_props(exit_button, 630, 486, 170, 114)
    canvas.add exit_button

    @main_dialog.update_arrange
  end

  def create_channel_control(canvas, normal_image_num, hover_image_num, left, top, width, height,
                             margin_left=0, margin_top=0, margin_right=0, margin_bottom=0)
    image_back = AntGui::Image.new(MediaUtil.get_img(get_image_path(normal_image_num)))
    image_active = AntGui::Image.new(MediaUtil.get_img(get_image_path(hover_image_num)))
    # image_back.z_order = image_active.z_order = z_order
    AntGui::Canvas.set_canvas_props(image_back, left, top, width, height)
    AntGui::Canvas.set_canvas_props(image_active, left, top, width, height)
    canvas.add image_back
    canvas.add image_active
    image_back.visible = true
    image_active.visible = false

    control = AntGui::Control.new
    AntGui::Canvas.set_canvas_props(control, left + margin_left, top + margin_top,
                                    width - margin_left - margin_right, height - margin_top - margin_bottom)
    control.on_mouse_enter {image_back.visible = false, image_active.visible = true}
    control.on_mouse_leave {image_back.visible = true, image_active.visible = false}
    canvas.add control
    control
  end

  def get_image_path(num)
    "channel_main/ChannelMain_#{num}.bmp"
  end

  def get_button_image_path(num)
    "channel_main/button/ChannelButton_#{num}.bmp"
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
    @anim_container.draw
    @main_dialog.draw ZOrder::Background

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