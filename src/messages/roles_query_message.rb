class RolesQueryMessage
  attr_reader :map_id

  def initialize(map_id)
    @map_id = map_id
  end

  def to_json(*a)
    {
        type: 'roles_query_message',
        data: {map_id: @map_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['map_id'])
  end
end