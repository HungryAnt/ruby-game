class MonsterTypeInfo
  COUNT = 2

  @@type_info = {}

  def self.put(id, type_info)
    @@type_info[id] = type_info
  end

  def self.get(id)
    @@type_info[id]
  end

  attr_reader :id, :name

  def initialize(id, name)
    @id, @name = id, name
  end
end