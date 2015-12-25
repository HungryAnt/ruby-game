class MonsterMessage
  class Action
    CREATE = 'create'
    UPDATE = 'update'
    UPDATE_HP = 'update_hp'
    DESTROY = 'destroy'
    MOVE = 'move'
    ATTACK = 'attack'
  end

  attr_reader :area_id, :item_map, :action, :detail

  def initialize(area_id, item_map, action, detail={})
    @area_id, @item_map = area_id, item_map
    @action = action
    @detail = detail
  end

  def to_json(*a)
    {
        type: 'monster_message',
        data: {area_id: @area_id, item_map: @item_map, action: @action, detail: @detail}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['area_id'], map['data']['item_map'], map['data']['action'], map['data']['detail'])
  end
end