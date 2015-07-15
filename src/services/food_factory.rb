class FoodFactory
  @@food_types = []

  def self.add(food_type)
    @@food_types << food_type
  end

  def self.random_food(x, y)
    food_type = @@food_types[rand(@@food_types.size)]
    Food.new(x, y, food_type)
  end
end