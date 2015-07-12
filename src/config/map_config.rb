class MapConfig
  DEFAULT_TAILS_PATH = 'resource/map/default_tails.txt'

  hill_area = Area.new('map/hill/grass_wood_back.bmp', 'map/hill.ogg', DEFAULT_TAILS_PATH)
  hill = Map.new([hill_area])

  school_ground = Area.new('map/school/school_ground.bmp', 'map/school_ground.ogg', DEFAULT_TAILS_PATH)
  school_lobby = Area.new('map/school/school_lobby.bmp', 'map/school_lobby.ogg', DEFAULT_TAILS_PATH)
  school_room = Area.new('map/school/school_room.bmp', 'map/school_room.ogg', DEFAULT_TAILS_PATH)
  school = Map.new [school_ground, school_lobby, school_room]

  MapManager.add_map :hill, hill
  MapManager.add_map :school, school
end