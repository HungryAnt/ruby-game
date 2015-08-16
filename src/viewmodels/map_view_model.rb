class MapViewModel
  attr_reader :areas, :current_area, :id

  def initialize(id, areas)
    ArgumentError "wrong areas #{areas}" if areas.nil? || areas.size == 0
    @id = id
    @areas = areas
    switch_to_first_area
  end

  def update
    @current_area.update
  end

  def draw
    @current_area.draw
  end

  def activate
    @current_area.activate
  end

  def mark_target(x, y)
    @current_area.mark_target x, y
  end

  def tile_block?(x, y)
    @current_area.tile_block? x, y
  end

  def random_available_position
    @current_area.random_available_position
  end

  def gateway?(x, y)
    @current_area.area.gateway? x, y
  end

  def switch_to_first_area
    @current_area = @areas[0]
  end

  def goto_area(role)
    tile = @current_area.area.tile role.x, role.y
    if Tiles.gateway? tile
      target_area, x, y, direction = @current_area.area.way_out tile
      @current_area = @areas.find {|area| area.area == target_area}
      role.x, role.y, role.direction = x, y, direction
      activate
    end
  end

  def clear_area_items
    @areas.each do |area_vm|
      area_vm.clear_item_vms
    end
  end
end