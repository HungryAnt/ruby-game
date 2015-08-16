class MapService
  def initialize
    autowired(ChatService)
    @maps = {}
    @map_list = []
    @current_map = nil
    @area_vm_dict = {}
  end

  def add_map(key, map)
    @maps[key] = map
    @map_list << map
  end

  def add_area(key, area_vm)
    @area_vm_dict[key] = area_vm
  end

  def get_area(key)
    @area_vm_dict[key]
  end

  def switch_map(key)
    map = @maps[key]
    if @current_map != map
      @chat_service.quit(@current_map.id) unless @current_map.nil?
      map.switch_to_first_area
      @current_map = map
      @current_map.activate
      @chat_service.join(map.id)
    end
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

  def draw_map
    @current_map.draw unless @current_map.nil?
  end

  def all_maps
    @map_list
  end
end