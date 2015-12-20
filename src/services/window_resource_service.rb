# coding: UTF-8
class WindowResourceService
  def init(window)
    @window = window
    @font_chat_bubble = Gosu::Font.new(window, 'Verdana', 17)
    @font_map_name = Gosu::Font.new(window, 'Verdana', 25)
    @normal_font = Gosu::Font.new(window, 'Verdana', 17)
    @warning_font = Gosu::Font.new(window, 'Verdana', 30)
    @goods_money_font = Gosu::Font.new(window, 'Verdana', 15)
    @font_25 = Gosu::Font.new(window, 'Verdana', 25)
    @font_16 = Gosu::Font.new(window, 'Verdana', 16)
    @font_12 = Gosu::Font.new(window, 'Verdana', 12)
    @font_14 = Gosu::Font.new(window, 'Verdana', 14)
    @font_13 = Gosu::Font.new(window, 'Verdana', 13)
  end

  def get_chat_bubble_font
    @font_chat_bubble
  end

  def get_sound_button
    MediaUtil.get_sample 'button.wav'
  end

  def get_channel(key)
    MediaUtil.get_sample "channel/#{key.to_s}.wav"
  end

  def get_map_name_font
    @font_map_name
  end

  def get_normal_font
    @normal_font
  end

  def get_warning_font
    @warning_font
  end

  def get_gold_image
    MediaUtil::get_img 'money/gold.bmp'
  end

  def get_silver_image
    MediaUtil::get_img 'money/silver.bmp'
  end

  def get_goods_money_font
    @goods_money_font
  end

  def get_font_25
    @font_25
  end

  def get_font_16
    @font_16
  end

  def get_font_14
    @font_14
  end

  def get_font_13
    @font_13
  end

  def get_font_12
    @font_12
  end

  def create_button(left, top, width, height,
                    normal_image_path, hover_image_path)
    button = AntGui::Control.new

    AntGui::Canvas::set_canvas_props(button, left, top, width, height)
    normal_image = AntGui::Image.new(MediaUtil.get_img normal_image_path)
    hover_image = AntGui::Image.new(MediaUtil.get_img hover_image_path)
    button.content = normal_image
    button.on_mouse_enter {button.content = hover_image; button.refresh}
    button.on_mouse_leave {button.content = normal_image; button.refresh}
    button.on_mouse_left_button_down {
      get_sound_button.play
      if block_given?
        yield
      end
    }
    button
  end
end