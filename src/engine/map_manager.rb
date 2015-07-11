class MapManager
  @@maps = {}
  @@current_map = nil

  def self::add_map(key, map)
    @@maps[key] = map
    @@current_map = map if @@current_map.nil?
  end

  def self::switch_map(key)
    map = @@maps[key]
    if @@current_map != map
      @@current_map = map
      @@current_map.activate
    end
  end

  def self::draw_map
    @@current_map.draw unless @@current_map.nil?
  end
end