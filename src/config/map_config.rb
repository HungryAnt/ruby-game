
def get_tail_path(name)
  "resource/map/#{name}.txt"
end

DEFAULT_TAILS_PATH = get_tail_path('default_tails')

hill_area = AreaViewModel.new('map/hill/grass_wood_back.bmp', 'map/hill.ogg', get_tail_path('grass_wood_back'))
hill = MapViewModel.new([hill_area])

school_ground = AreaViewModel.new('map/school/school_ground.bmp', 'map/school_ground.ogg', get_tail_path('school_ground'))
school_lobby = AreaViewModel.new('map/school/school_lobby.bmp', 'map/school_lobby.ogg', get_tail_path('school_lobby'))
school_room = AreaViewModel.new('map/school/school_room.bmp', 'map/school_room.ogg', get_tail_path('school_room'))
school = MapViewModel.new [school_ground, school_lobby, school_room]

MapManager.add_map :hill, hill
MapManager.add_map :school, school