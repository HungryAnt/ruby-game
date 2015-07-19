# coding: UTF-8

lambda {
  def get_tail_path(name)
    File.join(@base_src_dir, "resource/map/#{name}.txt")
  end

  def create_area(image_path, song_path, tiles_text)
    Area.new image_path, song_path, tiles_text
  end

  def create_map(key, areas)
    area_vms = areas.collect {|area|AreaViewModel.new area}
    map = MapViewModel.new(area_vms)
    MapManager.add_map key, map
  end

  search_pattern = File.join(File.dirname(__FILE__), 'area/*.rb')
  puts search_pattern

  Dir.glob(search_pattern).each do |file|
    require file
  end

}.call