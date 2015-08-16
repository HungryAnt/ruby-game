class FoodTypeInfo
  @@food_types = {}

  def self.put(id, food_type)
    @@food_types[id] = food_type
  end

  def self.get(id)
    @@food_types[id]
  end

  def self.random_id
    @@food_types.keys[rand(@@food_types.size)]
  end

  attr_reader :id, :name, :image_path, :energy

  def initialize(id, name, image_path, energy)
    @id, @name, @image_path, @energy = id, name, image_path, energy
  end
end