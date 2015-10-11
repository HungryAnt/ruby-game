class AreaQueryMessage
  attr_reader :map_id

  def initialize(type, map_id)
    @type = type
    @map_id = map_id
  end

  def to_json(*a)
    {
        type: @type,
        data: {map_id: @map_id}
    }.to_json(*a)
  end
end