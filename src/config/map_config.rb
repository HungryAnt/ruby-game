# coding: UTF-8

lambda {
  class MapManager
    attr_reader :map_service

    def initialize
      autowired(MapService)
    end
  end

  @map_manager = MapManager.new

  def get_tail_path(name)
    File.join(@base_src_dir, "resource/map/#{name}.txt")
  end

  def create_area(id, image_path, song_path, tiles_text)
    Area.new id, image_path, song_path, tiles_text
  end

  def create_map(key, areas)
    area_vms = areas.collect {|area|AreaViewModel.new area}
    map = MapViewModel.new(key.to_s, area_vms)
    @map_manager.map_service.add_map key, map
  end

  search_pattern = File.join(File.dirname(__FILE__), 'area/*.rb')
  puts search_pattern

  Dir.glob(search_pattern).each do |file|
    require file
  end

}.call