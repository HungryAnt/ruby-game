module PlayerCommonModule
  def get_current_map_id
    @map_service.current_map.id.to_s
  end

  def get_current_area_id
    @map_service.current_map.current_area.id.to_s
  end

  def get_user_id
    @player_service.user_id
  end
end