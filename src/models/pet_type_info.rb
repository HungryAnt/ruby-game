class PetTypeInfo
  @@type_info = {}
  @@pets = []

  def self.put(pet_type, type_info)
    @@type_info[pet_type] = type_info
    @@pets << pet_type
  end

  def self.get(pet_type)
    @@type_info[pet_type]
  end

  def self.all_pet_types
    @@type_info.keys
  end

  def self.print_all_pets
    @@pets.each { |pet| puts pet }
  end

  attr_reader :pet_type, :name, :height, :options

  def initialize(pet_type, name, height, options)
    @pet_type, @name, @height, @options = pet_type, name, height, options
  end
end