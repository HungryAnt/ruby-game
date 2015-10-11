require_relative 'area_query_message'

class AreaLargeRubbishesQueryMessage < AreaQueryMessage
  def initialize(map_id)
    super('area_large_rubbishes_query_message', map_id)
  end

  def self.from_map(map)
    new(map['data']['map_id'])
  end
end