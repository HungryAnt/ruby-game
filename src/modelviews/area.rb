class Area
  def initialize(image_path, song_path)
    @image = MediaUtil::get_tileable_img(image_path)
    @scale_x = GameConfig::WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::HEIGHT * 1.0 / @image.height
    @song_path = song_path
  end

  def activate
    SongManager.play_song @song_path
  end

  def draw
    @image.draw(0, 0, ZOrder::Background, @scale_x, @scale_y)
  end
end