require_relative 'area_query_message'

class AreaItemsQueryMessage < AreaQueryMessage
  def initialize(map_id)
    super('area_items_query_message', map_id)
  end

  def self.from_map(map)
    new(map['data']['map_id'])
  end
end