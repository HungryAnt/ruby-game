class Goods
  attr_reader :key, :price

  def initialize(key, price)
    @key, @price = key, price
  end

  def self.from_map(map)
    new(map['key'].to_s, ['price'].to_i)
  end
end