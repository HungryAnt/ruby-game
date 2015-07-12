class MapConfig
  hill_area = Area.new('map/hill/grass_wood_back.bmp', 'map/hill.ogg')
  hill = Map.new([hill_area])

  school_ground = Area.new('map/school/school_ground.bmp', 'map/school_ground.ogg')
  school_lobby = Area.new('map/school/school_lobby.bmp', 'map/school_lobby.ogg')
  school_room = Area.new('map/school/school_room.bmp', 'map/school_room.ogg')
  school = Map.new [school_ground, school_lobby, school_room]

  MapManager.add_map :hill, hill
  MapManager.add_map :school, school
end