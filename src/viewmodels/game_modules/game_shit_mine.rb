module GameShitMine
  def setup_mine
    role = @player_view_model.role
    mine = ShitMine.new role.x, role.y
    mine_vm = ShitMineViewModel.new mine
    get_current_area.add_shit_mine_vm mine_vm
  end
end