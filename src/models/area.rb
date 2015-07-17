class Area
  GRID_WIDTH = 10
  GRID_HEIGHT = 10

  attr_reader :image_path, :song_path, :tiles_path

  def initialize(image_path, song_path, tiles_path)
    @image_path, @song_path, @tiles_path = image_path, song_path, tiles_path
    lines = File.readlines(tiles_path).map { |line| line.chomp }
    init_tails lines
    init_available_positions
  end

  private

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

  def init_available_positions
    # 记录所有有效位置
    @available_positions = []

    0.upto(@row_count-1) do |row|
      0.upto(@col_count-1) do |col|
        if @tiles[row][col] == Tiles::None
          @available_positions << [GRID_WIDTH * col + GRID_WIDTH / 2, GRID_HEIGHT * row + GRID_HEIGHT / 2]
        end
      end
    end
  end

  public

  def tile_block?(x, y)
    row = y / GRID_HEIGHT
    col = x / GRID_WIDTH
    return true if row < 0 || row >= @row_count
    return true if col < 0 || col >= @col_count
    @tiles[row][col] == Tiles::Block
  end

  def random_available_position
    @available_positions[rand @available_positions.size]
  end
end