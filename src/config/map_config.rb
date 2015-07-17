
def get_tail_path(name)
  File.join(@base_src_dir, "resource/map/#{name}.txt")
end

def create_area(image_path, song_path, tiles_path)
  area = Area.new image_path, song_path, tiles_path
  AreaViewModel.new area
end

DEFAULT_TAILS_PATH = get_tail_path('default_tails')

hill_area = create_area('map/hill/grass_wood_back.bmp', 'map/hill.ogg', get_tail_path('grass_wood_back'))
hill = MapViewModel.new([hill_area])

school_ground = create_area('map/school/school_ground.bmp', 'map/school_ground.ogg', get_tail_path('school_ground'))
school_lobby = create_area('map/school/school_lobby.bmp', 'map/school_lobby.ogg', get_tail_path('school_lobby'))
school_room = create_area('map/school/school_room.bmp', 'map/school_room.ogg', get_tail_path('school_room'))
school = MapViewModel.new [school_ground, school_lobby, school_room]

MapManager.add_map :hill, hill
MapManager.add_map :school, school