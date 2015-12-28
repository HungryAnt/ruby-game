class ItemViewModel
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def id
    @item.id
  end

  def y
    @item.y
  end

  def mouse_touch?(mouse_x, mouse_y)
    Gosu::distance(@item.x, @item.y, mouse_x, mouse_y) < 23
  end

  def can_pick_up?(role)
    Gosu::distance(@item.x, @item.y, role.x, role.y) < 45
  end

  def name
    @item.name
  end
end