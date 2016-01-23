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

    def draw(font)
      Gosu::draw_rect @x, @y, ITEM_WIDTH, ITEM_HEIGHT, @color
      Gosu::draw_rect(@x, @y+ITEM_HEIGHT-5, ITEM_WIDTH, 5, 0xFF_FF0000) if @selected

      if Tiles.gateway? @tile
        font.draw_rel(@tile.to_s, @x + ITEM_WIDTH / 2, @y + ITEM_HEIGHT / 2,
                      ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xFF_FFFFFF)
      end
    end
  end

  def initialize
    @items = []
    x = 0
    [Tiles::NONE, Tiles::BLOCK, Tiles::INIT_POSITION, Tiles::GATEWAY].each do |tile|
      item = Item.new(tile, x, 0, Tiles::color(tile))
      x += ITEM_WIDTH
      @items << item
      @geteway_item = item if tile == Tiles::GATEWAY
    end
  end

  def draw(font)
    Gosu::draw_rect 0, 0, GameConfig::MAP_WIDTH, GameConfig::BOTTOM_HEIGHT, 0xFF_888888
    @items.each do |item|
      item.draw font
    end
  end

  def select_tile(x, y)
    @items.each do |item|
      if item.contains(x, y)
        select item
        return item.tile
      end
    end
    nil
  end

  def geteway=(geteway_tile)
    @geteway_item.tile = geteway_tile
    select @geteway_item
  end

  private

  def select(target_item)
    @items.each { |item| item.selected = item == target_item }
  end
end