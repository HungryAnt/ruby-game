class MapUserCountService
  def initialize
    @map_user_count_dict = {}
    @all_user_count = 0
  end

  def refresh_map_user_count(map_user_count_dict, all_user_count)
    @map_user_count_dict = map_user_count_dict
    @all_user_count = all_user_count
  end

  def get_map_user_count(map_id)
    return 0 unless @map_user_count_dict.include? map_id
    @map_user_count_dict[map_id]
  end

  def get_all_user_count
    # count = @map_user_count_dict.values.inject{|sum, x| sum + x }
    # return 0 if count.nil?
    # count
    @all_user_count
  end
end