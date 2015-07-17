require_relative "editor/tile_selector_view"

class MapEditorView
  DEFAULT_BORDER_WIDTH = 3

  def initialize(window)
    @window = window
    init_imgs
    init_tile_grid
    @tile_selector = TileSelectorView.new
  end

  def init_imgs
    maps = MapManager::all_maps
    @imgs = []
    maps.each do |map|
      map.areas.each do |area|
        @imgs << area.image
      end
    end

    @img_index = 0
    @current_img = @imgs[@img_index]
  end

  def init_tile_grid
    @row_count = GameConfig::MAP_HEIGHT / Area::GRID_WIDTH
    @col_count = GameConfig::MAP_WIDTH / Area::GRID_WIDTH

    @tiles = Array.new(@row_count)
    0.upto(@row_count-1) do |row|
      @tiles[row] = Array.new(@col_count)
      0.upto(@col_count-1) do |col|
        tile = Tiles::None
        if row < DEFAULT_BORDER_WIDTH ||
            row >= @row_count-DEFAULT_BORDER_WIDTH ||
            col < DEFAULT_BORDER_WIDTH ||
            col >= @col_count - DEFAULT_BORDER_WIDTH
          tile = Tiles::Block
        end
        @tiles[row][col] = tile
      end
    end

    @current_tile = Tiles::Block

    @editing = false
    @origin_row = 0
    @origin_col = 0
  end

  def update
    edit_grid
  end

  def draw
    @current_img.draw(0, 0, ZOrder::Background, 1, 1)

    draw_tile_grid

    @window.translate(0, GameConfig::MAP_HEIGHT) do
      @tile_selector.draw
    end
  end

  private def draw_tile_grid
    0.upto(@row_count-1) do |row|
      0.upto(@col_count-1) do |col|
        color = Tiles.color(@tiles[row][col])
        Gosu::draw_rect Area::GRID_WIDTH * col, Area::GRID_HEIGHT * row,
                        Area::GRID_WIDTH, Area::GRID_HEIGHT, color
      end
    end

    0.upto(@row_count-1) do |row|
      Gosu::draw_line 0, Area::GRID_HEIGHT * row, 0x88_000000,
                      GameConfig::MAP_WIDTH, Area::GRID_HEIGHT * row, 0x88_000000
    end

    0.upto(@col_count-1) do |col|
      Gosu::draw_line Area::GRID_WIDTH * col, 0, 0x88_000000,
                      Area::GRID_WIDTH * col, GameConfig::MAP_HEIGHT, 0x88_000000
    end
  end

  private def edit_grid
     x = @window.mouse_x.to_i
     y = @window.mouse_y.to_i
     if @editing && @current_tile
       rows = [@origin_row, y / Area::GRID_HEIGHT]
       cols = [@origin_col, x / Area::GRID_WIDTH]
       r_min, r_max = rows.min().to_i, rows.max().to_i
       c_min, c_max = cols.min().to_i, cols.max().to_i
       return if r_min > @row_count-1 || r_max < 0
       return if c_min > @col_count-1 || c_max < 0
       r_min, r_max = [0, r_min].max, [@row_count-1, r_max].min
       c_min, c_max = [0, c_min].max, [@col_count-1, c_max].min
       r_min.upto(r_max) do |row|
         c_min.upto(c_max) do |col|
           @tiles[row][col] = @current_tile
         end
       end
     end
  end

  def button_down(id)
    if id >= Gosu::Kb1 && id <= Gosu::Kb9
      @img_index = id - Gosu::Kb1
    elsif id == Gosu::KbLeft || id == Gosu::KbUp
      @img_index -= 1
    elsif id == Gosu::KbRight || id == Gosu::KbDown
      @img_index += 1
    end
    @img_index = [@imgs.size - 1, @img_index].min
    @img_index = [0, @img_index].max
    @current_img = @imgs[@img_index]

    if id == Gosu::MsLeft
      if @window.mouse_y > GameConfig::MAP_HEIGHT
        # 选择地图贴片
        @current_tile = @tile_selector.select_tile @window.mouse_x, @window.mouse_y-GameConfig::MAP_HEIGHT
      else
        # 开始编辑地图
        unless @current_tile.nil?
          @editing = true
          @origin_row = @window.mouse_y / Area::GRID_HEIGHT
          @origin_col = @window.mouse_x / Area::GRID_WIDTH
        end
      end
    end

    if id == Gosu::KbP
      print_tiles
    end
  end

  def print_tiles
    @tiles.each do |row_tiles|
      row_tiles.each do |tile|
        if tile == Tiles::Block
          print '#'
        else
          print ' '
        end
      end
      print "\n"
    end
  end

  def button_up(id)
    if id == Gosu::MsLeft
      @editing = false
    end
  end

  def needs_cursor?
    true
  end
end