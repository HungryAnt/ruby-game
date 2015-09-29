class MapUserCountMessage
  attr_reader :map_user_count_dict

  def initialize(map_user_count_dict)
    @map_user_count_dict = map_user_count_dict
  end

  def to_json(*a)
    {
        type: 'map_user_count_message',
        data: {map_user_count_dict: @map_user_count_dict}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['map_user_count_dict'])
  end
end