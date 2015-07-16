class FoodType
  attr_reader :id, :name, :image_path, :energy

  def initialize(id, name, image_path, energy)
    @id, @name, @image_path, @energy = id, name, image_path, energy
  end
end