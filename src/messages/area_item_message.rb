class AreaItemMessage
  attr_reader :area_id, :item_map

  def initialize(area_id, item_map)
    @area_id, @item_map = area_id, item_map
  end

  def to_json(*a)
    {
        type: 'join_message',
        data: {area_id: @area_id, item_map: @item_map}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['area_id'], map['data']['item_map'])
  end
end