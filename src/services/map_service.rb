class MapService
  def initialize
    autowired(CommunicationService)
    @maps = {}
    @map_list = []
    @current_map = nil
    @area_vm_dict = {}
    @map_user_count_dict = {}
  end

  def add_map(key, map)
    @maps[key] = map
    @map_list << map
  end

  def get_map(key)
    @maps[key]
  end

  def add_area(key, area_vm)
    @area_vm_dict[key] = area_vm
  end

  def get_area(key)
    @area_vm_dict[key.to_s]
  end

  def switch_map(key, role)
    map = @maps[key]
    if @current_map != map
      @communication_service.clear_chat_msgs
      @communication_service.quit(@current_map.id) unless @current_map.nil?
      map.switch_to_first_area
      @current_map = map
      @current_map.activate
      @communication_service.join(map.id, role)
    end
  end

  def quit_map
    return if @current_map.nil?
    @communication_service.clear_chat_msgs
    @communication_service.quit(@current_map.id) unless @current_map.nil?
    @current_map = nil
  end

  def current_map
    @current_map
  end

  def current_area
    current_map.current_area
  end

  def update_map
    @current_map.update unless @current_map.nil?
  end

  def draw_map(player_x, player_y)
    @current_map.draw player_x, player_y unless @current_map.nil?
  end

  def all_maps
    @map_list
  end

  def is_in_chat_map?
    !@current_map.nil?
  end
end