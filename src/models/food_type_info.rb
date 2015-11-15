class FoodTypeInfo
  @@food_type_infos = {}

  def self.put(id, food_type_info)
    @@food_type_infos[id] = food_type_info
  end

  def self.get(id)
    @@food_type_infos[id]
  end

  def self.random_id
    @@food_type_infos.keys[rand(@@food_type_infos.size)]
  end

  attr_reader :id, :name, :image_path

  def initialize(id, name, image_path)
    @id, @name, @image_path, @energy = id, name, image_path
  end
end