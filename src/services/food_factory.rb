class FoodFactory
  def self.random_food(x, y)
    Food.new(x, y, FoodTypeInfo.random_id)
  end
end