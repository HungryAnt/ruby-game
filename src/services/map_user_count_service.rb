class MapUserCountService
  def refresh_map_user_count(map_user_count_dict)
    @map_user_count_dict = map_user_count_dict
  end

  def get_map_user_count(map_id)
    return 0 unless @map_user_count_dict.include? map_id
    @map_user_count_dict[map_id]
  end
end