class MapManager
  @@maps = {}
  @@map_list = []
  @@current_map = nil

  def self::add_map(key, map)
    @@maps[key] = map
    @@map_list << map
  end

  def self::switch_map(key)
    map = @@maps[key]
    if @@current_map != map
      @@current_map = map
      @@current_map.activate
    end
  end

  def self::current_map
    @@current_map
  end

  def self::update_map
    @@current_map.update unless @@current_map.nil?
  end

  def self::draw_map
    @@current_map.draw unless @@current_map.nil?
  end

  def self::all_maps
    @@map_list
  end
end