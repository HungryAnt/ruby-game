class Goods
  attr_reader :key, :price, :equipment_type

  def initialize(key, price, equipment_type)
    @key, @price, @equipment_type = key, price, equipment_type
  end

  def self.from_map(map)
    new(map['key'].to_s, map['price'].to_i, to_equipment_type(map['goodsType'].to_s))
  end

  def self.to_equipment_type(goods_type)
    goods_type.gsub(/(.)([A-Z])/, '\1_\2').downcase
  end
end