class TileSelectorView
  ITEM_WIDTH = 50
  ITEM_HEIGHT = 37

  class Item
    attr_accessor :tile, :selected

    def initialize(tile, x, y, color)
      @tile = tile
      @x = x
      @y = y
      @color = color
      @selected = false
    end

    def contains(x, y)
      x >= @x && x < @x+ITEM_WIDTH && y >= @y && y < @y+ITEM_HEIGHT
    end

    def draw
      Gosu::draw_rect @x, @y, ITEM_WIDTH, ITEM_HEIGHT, @color
      Gosu::draw_rect(@x, @y+ITEM_HEIGHT-5, ITEM_WIDTH, 5, 0xFF_FF0000) if @selected
    end
  end

  def initialize
    @items = []
    x = 0
    [Tiles::NONE, Tiles::BLOCK, Tiles::GATEWAY].each do |tile|
      item = Item.new(tile, x, 0, Tiles::color(tile))
      x += ITEM_WIDTH
      @items << item
    end
  end

  def draw
    Gosu::draw_rect 0, 0, GameConfig::MAP_WIDTH, GameConfig::BOTTOM_HEIGHT, 0xFF_888888
    @items.each do |item|
      item.draw
    end
  end

  def select_tile(x, y)
    selectd_tile = nil
    @items.each do |item|
      if item.contains(x, y)
        selectd_tile = item.tile
        item.selected = true
      else
        item.selected = false
      end
    end
    selectd_tile
  end
end