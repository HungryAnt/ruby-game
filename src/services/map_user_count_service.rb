class MapUserCountService
  def initialize
    @map_user_count_dict = {}
    @all_user_count = 0
    @map_large_rubbish_dict = {}
  end

  def refresh_map_user_count(map_user_count_dict, all_user_count,
                             map_large_rubbish_dict, map_monster_dict)
    @map_user_count_dict = map_user_count_dict
    @all_user_count = all_user_count
    @map_large_rubbish_dict = map_large_rubbish_dict
    @map_monster_dict = map_monster_dict
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

  def has_large_rubbish?(map_id)
    return false unless @map_large_rubbish_dict.include? map_id
    @map_large_rubbish_dict[map_id]
  end

  def has_monster?(map_id)
    return false unless @map_monster_dict.include? map_id
    @map_monster_dict[map_id]
  end
end