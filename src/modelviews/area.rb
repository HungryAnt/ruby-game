class Area
  attr_reader :image

  def initialize(image_path, song_path)
    @image = MediaUtil::get_tileable_img(image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @song_path = song_path
    @anim_container = AnimationContainer.new
  end

  def update
    @anim_container.update
  end

  def draw
    @image.draw(0, 0, ZOrder::Background, @scale_x, @scale_y)
    @anim_container.draw
  end

  def activate
    SongManager.play_song @song_path
  end

  def target x, y
    anim = AnimationManager::get_anim :area_click
    anim_holder = AnimationHolder.new anim, x, y, ZOrder::Background, false, 1
    @anim_container.add_anim anim_holder
  end
end