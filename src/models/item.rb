class Item
  attr_reader :item_type

  def initialize(item_type)
    @item_type = item_type
  end

  class ItemType
    FOOD = :food
    RUBBISH = :rubbish
    SPECIAL = :special
  end

  
end