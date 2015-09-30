class MapUserCountMessage
  attr_reader :map_user_count_dict, :all_user_count

  def initialize(map_user_count_dict, all_user_count)
    @map_user_count_dict = map_user_count_dict
    @all_user_count = all_user_count
  end

  def to_json(*a)
    {
        type: 'map_user_count_message',
        data: {map_user_count_dict: @map_user_count_dict, all_user_count:@all_user_count}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['map_user_count_dict'],
        map['data']['all_user_count'].to_i)
  end
end