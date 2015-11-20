class PetTypeInfo
  @@type_info = {}

  def self.put(pet_type, type_info)
    @@type_info[pet_type] = type_info
  end

  def self.get(pet_type)
    @@type_info[pet_type]
  end

  def self.all_pet_types
    @@type_info.keys
  end

  attr_reader :pet_type, :name

  def initialize(pet_type, name)
    @pet_type, @name = pet_type, name
  end
end