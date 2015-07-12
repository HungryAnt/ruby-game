module Tiles
  None = 0
  Earth = 1
end

class MapEditorView

  GRID_WIDTH = 10
  GRID_HEIGHT = 10

  def initialize
    maps = MapManager::all_maps
    @imgs = []

    maps.each do |map|
      map.areas.each do |area|
        @imgs << area.image
      end
    end

    @img_index = 0
    @current_img = @imgs[@img_index]


    @raw_count = GameConfig::MAP_HEIGHT / GRID_WIDTH
    @col_count = GameConfig::MAP_WIDTH / GRID_WIDTH

    @tiles = Array.new(@raw_count)
    0.upto(@raw_count) do |row|
      @tiles[row] = Array.new(@col_count)
      0.upto(@col_count) do |col|
        @tiles[row][col] = Tiles::None
      end
    end

  end

  def update
  end

  def draw
    @current_img.draw(0, 0, ZOrder::Background, 1, 1)

    0.upto(@raw_count) do |row|
      0.upto(@col_count) do |col|
        tile = @tiles[row][col]
        if tile == Tiles::None
          next
        end
        Gosu::draw_rect GRID_WIDTH * col, GRID_HEIGHT * row,
                        GRID_WIDTH, GRID_HEIGHT, 0x88_0000FF
      end
    end

    0.upto(@raw_count) do |row|
      Gosu::draw_line 0, GRID_HEIGHT * row, 0x88_000000,
                      GameConfig::MAP_WIDTH, GRID_HEIGHT * row, 0x88_000000
    end

    0.upto(@col_count) do |col|
      Gosu::draw_line GRID_WIDTH * col, 0, 0x88_000000,
                      GRID_WIDTH * col, GameConfig::MAP_HEIGHT, 0x88_000000
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
  end

  def needs_cursor?
    true
  end
end