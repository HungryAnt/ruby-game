class AreaViewModel
  attr_reader :image, :area, :food_vms

  def initialize(area)
    @area = area
    @image = MediaUtil::get_tileable_img(@area.image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @anim_container = AnimationContainer.new
    @food_vms = []
    init_covering
  end

  def init_covering
    @covering_views = []
    @area.coverings.each do |covering|
      covering_view = {
        :image => MediaUtil::get_tileable_img(covering[:path]),
        :x => covering[:x] * @scale_x,
        :y => covering[:y] * @scale_y
      }
      @covering_views << covering_view
    end
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
    draw_covering
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

  private
  def draw_covering
    @covering_views.each do |covering_view|
      covering_view[:image].draw(covering_view[:x], covering_view[:y], ZOrder::Covering)
    end
  end
end