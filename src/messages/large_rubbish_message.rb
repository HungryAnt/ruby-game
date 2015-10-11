class LargeRubbishMessage
  class Action
    CREATE = 'create'
    UPDATE = 'update'
    DESTROY = 'destroy'
  end

  attr_reader :area_id, :item_map, :action

  def initialize(area_id, item_map, action)
    @area_id, @item_map = area_id, item_map
    @action = action
  end

  def to_json(*a)
    {
        type: 'large_rubbish_message',
        data: {area_id: @area_id, item_map: @item_map, action: @action}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['area_id'], map['data']['item_map'], map['data']['action'])
  end
end