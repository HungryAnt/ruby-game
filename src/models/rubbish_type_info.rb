class RubbishTypeInfo
  COUNT = 12

  @@type_info = {}
  @@type_image = {}

  def self.put(id, type_info)
    @@type_info[id] = type_info
  end

  def self.get(id)
    @@type_info[id]
  end

  def self.cache_image(id, image)
    @@type_image[id] = image
  end

  def self.get_image(id)
    @@type_image[id]
  end

  attr_reader :id, :name, :image_path

  def initialize(id, name, image_path)
    @id, @name, @image_path = id, name, image_path
  end
end