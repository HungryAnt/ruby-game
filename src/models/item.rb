require_relative 'location'

class Item
  class ItemType
    FOOD = 'food'
    RUBBISH = 'rubbish'
    NUTRIENT = 'nutrient'
    SPECIAL = 'special'
  end

  include Location

  attr_reader :id, :item_type

  def init_item(id, item_type, x, y)
    @id = id
    @item_type = item_type
    init_location x, y
  end

  def to_map
    {
        'id' => @id,
        'item_type' => @item_type,
        'x' => @x,
        'y' => @y
    }
  end

  def to_id_map
    {
        id: @id
    }
  end
end