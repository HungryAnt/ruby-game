class MapViewModel
  attr_reader :areas, :current_area, :id, :name, :map_type
  attr_accessor :player_hit_success_proc, :player_be_battered_proc

  def initialize(id, name, map_type, areas)
    ArgumentError "wrong areas #{areas}" if areas.nil? || areas.size == 0
    @id = id
    @name, @map_type = name, map_type
    @areas = areas
    @player_hit_success_proc = @player_be_battered_proc = nil
    switch_to_first_area
  end

  def update
    @current_area.update
  end

  def draw(player_x, player_y)
    @current_area.draw player_x, player_y
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

  def clear_items
    @areas.each do |area_vm|
      area_vm.clear_item_vms
      area_vm.clear_enemy_vms
      area_vm.clear_shit_mine_vms
    end
  end

  def on_player_hit_success
    @player_hit_success_proc.call unless @player_hit_success_proc.nil?
  end

  def on_player_be_battered
    @player_be_battered_proc.call unless @player_be_battered_proc.nil?
  end
end