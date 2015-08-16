class AreaItemsQueryMessage
  attr_reader :map_id

  def initialize(map_id)
    @map_id = map_id
  end

  def to_json(*a)
    {
        type: 'area_items_query_message',
        data: {map_id: @map_id}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['map_id'])
  end
end