class PackageItemsViewModel
  def initialize(player_vm)
    @player_vm = player_vm
  end

  # def get_items
  #   @player_vm.role.package.items
  # end

  def get_vehicles
    @player_vm.role.package.items.find_all {|item| item.instance_of? Equipment}
  end

  def get_rubbishes
    @player_vm.role.rubbish_bin.get_rubbishes
  end

  def get_nutrients
    @player_vm.role.nutrient_bin.get_nutrients
  end

  def choose_equipment(equipment)
    @player_vm.equip(EquipmentViewModelFactory.create_equipment(equipment))
    @player_vm.set_driving true
  end
end