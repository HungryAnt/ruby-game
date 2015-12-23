class MonsterTypeInfo
  COUNT = 2

  @@type_info = {}

  def self.put(id, type_info)
    @@type_info[id] = type_info
  end

  def self.get(id)
    @@type_info[id]
  end

  attr_reader :id, :name, :height

  def initialize(id, name, height)
    @id, @name, @height = id, name, height
  end
end