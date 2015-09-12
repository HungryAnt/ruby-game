class PackageItemsViewModel
  def initialize(player_vm)
    @player_vm = player_vm
  end

  def get_items
    @player_vm.role.package.items
  end

  def choose_equipment(equipment)
    @player_vm.equip(EquipmentViewModelFactory.create_equipment(equipment))
    @player_vm.driving = true
  end
end