class FoodType
  attr_reader :id, :name, :image_path

  def initialize(id, name, image_path)
    @id, @name, @image_path = id, name, image_path
  end
end