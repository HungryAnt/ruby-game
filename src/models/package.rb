module Package
  attr_reader :items
  attr_reader :capacity

  def init_package(capacity)
    @capacity = capacity
    @items = []
  end

  private :init_package

  def add(item)
    @items << item
  end

  def discard(item)
    @items.reject! {|e| e.equal?item}
  end

  def [](i)
    check_index i
    @items[i]
  end

  def []=(i, item)
    check_index i
    @items[i] = item
  end

  def check_index(i)
    raise ArgumentError "wrong index:#{i} capacity:#{@capacity}" if i < 0 || i >= @capacity
  end

  private :check_index

  def <<(item)
    add(item)
  end
end