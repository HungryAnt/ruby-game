class MapService
  def initialize
    @maps = {}
    @map_list = []
    @current_map = nil
  end

  def add_map(key, map)
    @maps[key] = map
    @map_list << map
  end

  def switch_map(key)
    map = @maps[key]
    if @current_map != map
      @current_map = map
      @current_map.activate
    end
  end

  def current_map
    @current_map
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