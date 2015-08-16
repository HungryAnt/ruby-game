class FoodFactory
  @@id = 0

  def self.random_food(x, y)
    food = Food.new("id-#{@@id}#", x, y, FoodTypeInfo.random_id)
    @@id += 1
    food
  end
end