class PetMessage
  APPEAR = 'appear'
  DISAPPEAR = 'disappear'

  attr_reader :pet_id, :pet_type, :action, :pet_map, :map_id, :area_id, :destination

  def initialize(pet_id, pet_type, action, pet_map, map_id, area_id,
                 destination={})
    @pet_id, @pet_type, @pet_map = pet_id, pet_type, pet_map
    @action = action
    @map_id, @area_id = map_id, area_id
    @destination = destination
  end

  def to_json(*a)
    {
        type: 'pet_message',
        data: {
            pet_id: @pet_id,
            pet_type: @pet_type,
            action: @action,
            pet_map: @pet_map,
            map_id: @map_id,
            area_id: @area_id,
            destination: @destination
        }
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['pet_id'], map['data']['pet_type'], map['data']['action'], map['data']['pet_map'],
        map['data']['map_id'], map['data']['area_id'], map['data']['destination'])
  end
end