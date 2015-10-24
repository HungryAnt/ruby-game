class LargeRubbishTypeInfo
  COUNT = 29

  @@type_info = {}

  def self.put(id, type_info)
    @@type_info[id] = type_info
  end

  def self.get(id)
    @@type_info[id]
  end

  attr_reader :id, :name, :images

  def initialize(id, name, images)
    @id, @name = id, name
    @images = images
  end
end