class PackageItemsViewModel
  def initialize(player_vm)
    @player_vm = player_vm
  end

  def get_vehicles
    @player_vm.role.package.items.find_all {|item| item.instance_of? Equipment}
  end

  def get_rubbishes
    @player_vm.role.rubbish_bin.get_rubbishes
  end

  def get_nutrients
    @player_vm.role.nutrient_bin.get_nutrients
  end

  def get_pets
    @player_vm.role.pet_package.items
  end

  def choose_equipment(equipment)
    @player_vm.equip(EquipmentViewModelFactory.create_equipment(equipment))
    @player_vm.set_driving true
  end

  def choose_pet(pet)
    @player_vm.choose_pet pet
  end
end