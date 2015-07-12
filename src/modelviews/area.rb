class Area
  GRID_WIDTH = 10
  GRID_HEIGHT = 10

  attr_reader :image

  def initialize(image_path, song_path, tiles_path)
    @image = MediaUtil::get_tileable_img(image_path)
    @scale_x = GameConfig::MAP_WIDTH * 1.0 / @image.width
    @scale_y = GameConfig::MAP_HEIGHT * 1.0 / @image.height
    @song_path = song_path
    @anim_container = AnimationContainer.new

    lines = File.readlines(tiles_path).map { |line| line.chomp }
    init_tails lines
  end

  def init_tails(lines)
    @row_count = lines.size
    @col_count = lines[0].size
    @tiles = Array.new(@row_count) do |row|
      Array.new(@col_count) do |col|
        case lines[row][col, 1]
          when '#'
            Tiles::Block
          else
            Tiles::None
        end
      end
    end
    # print "tiles.size #{@tiles.size} tiles[0].size #{@tiles[0].size}"
  end

  def tile_block?(x, y)
    row = y / GRID_HEIGHT
    col = x / GRID_WIDTH
    return true if row < 0 || row >= @row_count
    return true if col < 0 || col >= @col_count
    @tiles[row][col] == Tiles::Block
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

  def target(x, y)
    anim = AnimationManager::get_anim :area_click
    anim_holder = AnimationHolder.new anim, x, y, ZOrder::Background, false, 1
    @anim_container.add_anim anim_holder
  end
end