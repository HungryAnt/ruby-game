require_relative 'game_element'

class GamePackage
  include GameElement

  attr_reader :items
  attr_reader :capacity

  def initialize(capacity)
    @capacity = capacity
    @items = []
  end

  def add(item)
    @items << item
  end

  def discard()
    @item
  end

  def [](i)
    @items[i]
  end

  def []=(i, item)
    @items[i] = item
  end

  def << item
    add(item)
  end
end