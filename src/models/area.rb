class Area
  GRID_WIDTH = 10
  GRID_HEIGHT = 10

  attr_accessor :gateway
  attr_reader :id, :image_path, :song_path, :tiles, :coverings, :initial_position, :visual_elements

  def initialize(id, image_path, song_path, tiles_text)
    @id = id
    @image_path, @song_path = image_path, song_path
    # lines = File.readlines(tiles_path).map { |line| line.chomp }
    init_tails tiles_text.lines.map {|line|line.chomp}
    init_available_positions
    @initial_position = get_initial_position
    @gateway = {}
    @coverings = []
    @visual_elements = []
  end

  private

  def init_tails(lines)
    @row_count = lines.size
    @col_count = lines[0].size
    @tiles = Array.new(@row_count) do |row|
      Array.new(@col_count) do |col|
        lines[row][col, 1]
      end
    end
    puts "area row_count #{@row_count} col_count #{@col_count}"
    # print "tiles.size #{@tiles.size} tiles[0].size #{@tiles[0].size}"
  end

  def init_available_positions
    # 记录所有有效位置
    @available_positions = []

    0.upto(@row_count-1) do |row|
      0.upto(@col_count-1) do |col|
        if @tiles[row][col] == Tiles::NONE
          @available_positions << get_position(row, col)
        end
      end
    end
  end

  def get_initial_position
    0.upto(@row_count-1) do |row|
      0.upto(@col_count-1) do |col|
        if @tiles[row][col] == Tiles::INIT_POSITION
          return get_position(row, col)
        end
      end
    end
    [300, 300]
  end

  def get_position(row, col)
    [GRID_WIDTH * col + GRID_WIDTH / 2, GRID_HEIGHT * row + GRID_HEIGHT / 2]
  end

  public

  def add_surface(surface)
    surface[:zorder] = :surface
    add_covering(surface)
  end

  def add_covering(convering)
    if convering[:zorder].nil?
      convering[:zorder] = :over  # :surface / over
    end
    @coverings << convering
  end

  # visual_element 参与地图物品y坐标排序显示
  def add_visual_element(params={})
    image_path = params.include?(:image_path) ? params[:image_path] : nil
    anim_key = params.include?(:anim) ? params[:anim] : nil
    left = params[:left]
    top = params[:top]
    y = params[:y]
    @visual_elements << AreaVisualElement.new(image_path, anim_key, left, top, y)
  end

  def tile_block?(x, y)
    row, col = get_row_col x, y
    return true if out_of_range? row, col
    @tiles[row][col] == Tiles::BLOCK
  end

  def random_available_position
    @available_positions[rand @available_positions.size]
  end

  # def gateway?(x, y)
  #   row, col = get_row_col x, y
  #   return false if out_of_range? row, col
  #   Tiles.gateway? @tiles[row][col]
  # end

  def tile(x, y)
    row, col = get_row_col x, y
    return nil if out_of_range? row, col
    @tiles[row][col]
  end

  def gateway?(x, y)
    tile = tile(x, y)
    return false if tile.nil?
    @gateway.include? tile.to_sym
  end

  def way_out(gateway_tile)
    unless @gateway.include? gateway_tile.to_sym
      raise ArgumentError "wrong gateway_tile #{gateway_tile}"
    end
    target = @gateway[gateway_tile.to_sym]
    target_area = target[:area]
    row, col = target_area.find_tile(gateway_tile)
    x, y = get_position(row, col)
    [target_area, x, y, target[:direction]]
  end

  def find_tile(tile)
    0.upto(@row_count-1) do |row|
      0.upto(@col_count-1) do |col|
        if @tiles[row][col] == tile
          return [row, col]
        end
      end
    end
    raise ArgumentError "wrong tail #{tile}"
  end

  private
  def get_row_col(x, y)
    [y / GRID_HEIGHT, x / GRID_WIDTH]
  end

  def out_of_range?(row, col)
    return true if row < 0 || row >= @row_count
    return true if col < 0 || col >= @col_count
  end
end