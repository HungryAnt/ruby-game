require_relative "editor/tile_selector_view"

class MapEditorView
  DEFAULT_BORDER_WIDTH = 3

  PAGE_ROW_COUNT = GameConfig::MAP_HEIGHT / Area::GRID_HEIGHT
  PAGE_COL_COUNT = GameConfig::MAP_WIDTH / Area::GRID_WIDTH

  def initialize(window)
    autowired(MapService)
    @window = window
    init_areas
    init_tile_grid
    @tile_selector = TileSelectorView.new
    @font = Gosu::Font.new(20)
    @font_small_gateway_font = Gosu::Font.new(12)
  end

  def init_areas
    if @map_service.current_map.nil?
      maps = @map_service::all_maps
    else
      maps = [@map_service.current_map]
    end
    @areas = []
    maps.each do |map|
      map.areas.each do |area_vm|
        @areas << area_vm
      end
    end

    switch_to_area 0, 0, 0
  end

  def init_tile_grid
    @current_tile = Tiles::BLOCK

    @editing = false
    @origin_row = 0
    @origin_col = 0
  end

  def update
    edit_grid
  end

  def draw
    @current_area.image.draw(-@col_offset * Area::GRID_WIDTH,
                             -@row_offset * Area::GRID_HEIGHT,
                             ZOrder::Background, 1, 1)
    draw_tile_grid

    Gosu::translate(0, GameConfig::MAP_HEIGHT) do
      @tile_selector.draw @font
    end

    @font.draw("Row:#{@window.mouse_y.to_i/Area::GRID_HEIGHT} Col:#{@window.mouse_x.to_i/Area::GRID_WIDTH}",
               GameConfig::MAP_WIDTH - 200, GameConfig::MAP_HEIGHT, ZOrder::UI, 1.0, 1.0, 0xff_ffffff)
  end

  def button_down(id)
    # if id >= Gosu::Kb1 && id <= Gosu::Kb9
    #   @area_index = id - Gosu::Kb1

    area_index_diff = row_offset_diff = col_offset_diff = 0

    if id == Gosu::Kb1
      area_index_diff = -1
    elsif id == Gosu::Kb2
      area_index_diff = 1
    elsif id == Gosu::KbUp
      row_offset_diff = -PAGE_ROW_COUNT / 2
    elsif id == Gosu::KbDown
      row_offset_diff = PAGE_ROW_COUNT / 2
    elsif id == Gosu::KbLeft
      col_offset_diff = -PAGE_COL_COUNT / 2
    elsif id == Gosu::KbRight
      col_offset_diff = PAGE_COL_COUNT / 2
    end

    switch_area area_index_diff, row_offset_diff, col_offset_diff

    if id == Gosu::MsLeft
      if @window.mouse_y > GameConfig::MAP_HEIGHT
        # 选择地图贴片
        @current_tile = @tile_selector.select_tile @window.mouse_x, @window.mouse_y-GameConfig::MAP_HEIGHT
      else
        # 开始编辑地图
        unless @current_tile.nil?
          @editing = true
          @origin_row = get_row_index(@window.mouse_y)
          @origin_col = get_col_index(@window.mouse_x)
        end
      end
    end

    if id >= Gosu::KbA && id <= Gosu::KbZ && id != Gosu::KbX && id != Gosu::KbP
      tile = ('A'.ord + id - Gosu::KbA).chr
      @current_tile = tile
      @tile_selector.geteway = tile
    end

    if id == Gosu::KbP
      print_tiles
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

  private

  def switch_area(area_index_diff, row_offset_diff, col_offset_diff)
    switch_to_area @area_index + area_index_diff,
                   @row_offset + row_offset_diff,
                   @col_offset + col_offset_diff
  end

  def switch_to_area(area_index, row_offset, col_offset)
    area_index = [@areas.size - 1, area_index].min
    area_index = [0, area_index].max

    @area_index = area_index
    @current_area = @areas[area_index]
    @row_count = @current_area.row_count
    @col_count = @current_area.col_count

    row_offset = [@row_count - PAGE_ROW_COUNT, row_offset].min
    row_offset = [0, row_offset].max

    col_offset = [@col_count - PAGE_COL_COUNT, col_offset].min
    col_offset = [0, col_offset].max

    @row_offset = row_offset
    @col_offset = col_offset
  end

  def draw_tile_grid
    0.upto(PAGE_ROW_COUNT - 1) do |row|
      0.upto(PAGE_COL_COUNT - 1) do |col|
        # puts "row #{row} col #{col}"
        tile = @current_area.tiles[@row_offset + row][@col_offset + col]
        color = Tiles.color(tile)
        left = Area::GRID_WIDTH * col
        top = Area::GRID_HEIGHT * row
        Gosu::draw_rect left, top, Area::GRID_WIDTH, Area::GRID_HEIGHT, color
        if Tiles.gateway? tile
          @font_small_gateway_font.draw_rel(
              tile.to_s, left + Area::GRID_WIDTH / 2, top + Area::GRID_HEIGHT / 2,
              ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xFF_FFFFFF)
        end
      end
    end

    0.upto(PAGE_ROW_COUNT - 1) do |row|
      Gosu::draw_line 0, Area::GRID_HEIGHT * row, 0x88_000000,
                      GameConfig::MAP_WIDTH, Area::GRID_HEIGHT * row, 0x88_000000
    end

    0.upto(PAGE_COL_COUNT - 1) do |col|
      Gosu::draw_line Area::GRID_WIDTH * col, 0, 0x88_000000,
                      Area::GRID_WIDTH * col, GameConfig::MAP_HEIGHT, 0x88_000000
    end
  end

  def edit_grid
    x = @window.mouse_x.to_i
    y = @window.mouse_y.to_i
    if @editing && @current_tile
      rows = [@origin_row, get_row_index(y)]
      cols = [@origin_col, get_col_index(x)]
      r_min, r_max = rows.min().to_i, rows.max().to_i
      c_min, c_max = cols.min().to_i, cols.max().to_i
      return if r_min > @row_count-1 || r_max < 0
      return if c_min > @col_count-1 || c_max < 0
      r_min, r_max = [0, r_min].max, [@row_count-1, r_max].min
      c_min, c_max = [0, c_min].max, [@col_count-1, c_max].min
      r_min.upto(r_max) do |row|
        c_min.upto(c_max) do |col|
          @current_area.tiles[row][col] = @current_tile
        end
      end
    end
  end

  def print_tiles
    @current_area.tiles.each do |row_tiles|
      row_tiles.each { |tile| print tile }
      print "\n"
    end
  end

  def get_row_index(y)
    @row_offset + y / Area::GRID_HEIGHT
  end

  def get_col_index(x)
    @col_offset + x / Area::GRID_WIDTH
  end
end