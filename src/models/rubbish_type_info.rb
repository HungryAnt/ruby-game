class RubbishTypeInfo
  @@type_info = {}

  def self.put(id, type_info)
    @@type_info[id] = type_info
  end

  def self.get(id)
    @@type_info[id]
  end

  attr_reader :id, :name, :image_path

  def initialize(id, name, image_path)
    @id, @name, @image_path = id, name, image_path
  end
end