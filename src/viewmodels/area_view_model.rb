class AreaViewModel
  attr_reader :image, :area, :food_vms

  def initialize(area)
    @area = area
    @image = MediaUtil::get_tileable_img(@area.image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @anim_container = AnimationContainer.new
    @food_vms = []
  end

  def tiles
    @area.tiles
  end

  def update
    @anim_container.update
  end

  def draw
    @image.draw(0, 0, ZOrder::Background, @scale_x, @scale_y)
    @anim_container.draw
  end

  def activate
    SongManager.play_song @area.song_path
  end

  def mark_target(x, y)
    anim = AnimationManager::get_anim :area_click
    anim_holder = AnimationHolder.new anim, x, y, ZOrder::UI, false, 1
    @anim_container.add_anim anim_holder
  end

  def tile_block?(x, y)
    @area.tile_block? x, y
  end

  def random_available_position
    @area.random_available_position
  end

end