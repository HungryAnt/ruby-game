# coding: UTF-8
class WindowResourceService
  def init(window)
    @window = window
    @font_chat_bubble = Gosu::Font.new(window, 'Verdana', 17)
  end

  def get_chat_bubble_font
    @font_chat_bubble
  end

  def get_sound_button
    MediaUtil.get_sample 'button.wav'
  end

  def get_channel_back_music
    MediaUtil.get_song 'channel/back.ogg'
  end

  def get_channel(key)
    MediaUtil.get_sample "channel/#{key.to_s}.wav"
  end
end