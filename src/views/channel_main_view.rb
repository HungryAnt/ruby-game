# coding: UTF-8

class ChannelMainView
  def initialize
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
  end

  def init_channel_element

  end

  def register_select_map(&call_back)
    @select_map_call_back = call_back
  end

  def update

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
  end

  def button_down(id)
    case id
      when Gosu::MsLeft
        @select_map_call_back.call :grass_wood_back
    end
  end

  def button_up(id)

  end

  def needs_cursor?
    true
  end
end