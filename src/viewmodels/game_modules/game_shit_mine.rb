module GameShitMine
  def setup_mine
    role = @player_view_model.role
    mine = ShitMine.new role.x, role.y
    mine_vm = ShitMineViewModel.new mine
    get_current_area.add_shit_mine_vm mine_vm
  end

  def bomb_mine
    get_current_area.get_shit_mine_vms.each { |shit_mine_vm| shit_mine_vm.bomb }
  end

  def travel_shit_mines
    get_current_area.refresh_shit_mine_vms.each { |shit_mine_vm| yield shit_mine_vm }
  end
end