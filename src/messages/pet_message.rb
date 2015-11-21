class PetMessage
  attr_reader :pet_id, :pet_type, :pet_map

  def initialize(pet_id, pet_type, pet_map)
    @pet_id, @pet_type, @pet_map = pet_id, pet_type, pet_map
  end

  def to_json(*a)
    {
        type: 'pet_message',
        data: {pet_id: @pet_id, pet_type: @pet_type, pet_map:@pet_map}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['pet_id'], map['data']['pet_type'], map['data']['pet_map'])
  end
end