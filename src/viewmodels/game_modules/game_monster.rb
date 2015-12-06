module GameMonster
  def init_monsters
    @monster_vms = []
    monster = Monster.new('xxx', 'monster_0002', 300, 300)
    @monster_vms << MonsterViewModel.new(monster)

    # monster = Monster.new('xxx', 'monster_0004', 600, 300)
    # @monster_vms << MonsterViewModel.new(monster)
  end

  def travel_monsters
    @monster_vms.each { |monster_vm| yield monster_vm }
  end

  def monster_move_to(x, y)
    return if @monster_vms.count == 0
    @monster_vms.each { |monster_vm| monster_vm.move_to x, y }
  end
end