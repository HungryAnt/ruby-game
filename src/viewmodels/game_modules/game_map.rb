module GameMap
  def init_map
    @sound_join_map = MediaUtil::get_sample('join_map.wav')
  end

  def switch_map(map_id)
    current_map = get_current_map
    return if !current_map.nil? && map_id == current_map.id.to_sym
    @map_service.switch_map map_id, @player_view_model.role
    @role_vm_dict.clear
    @pet_vm_dict.clear
    @player_view_model.switch_to_new_map
    @sound_join_map.play
  end

  def quit_map
    @player_view_model.disappear_pets
    @map_service.quit_map
  end

  private

  def get_current_map
    @map_service.current_map
  end

  def get_current_area
    get_current_map.current_area
  end

  def is_current_area(area_id)
    map = get_current_map
    return false if map.nil?
    area_id == map.current_area.id
  end

  def is_in_chat_map
    @map_service.is_in_chat_map?
  end
end