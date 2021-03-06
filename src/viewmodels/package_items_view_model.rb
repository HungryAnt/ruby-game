class PackageItemsViewModel
  def initialize(player_vm)
    @player_vm = player_vm
  end

  def get_equipments(equipment_type)
    @player_vm.role.get_equipments equipment_type
  end

  # def get_vehicles
  #   @player_vm.role.package.items.find_all {|item| item.instance_of? Equipment}
  # end
  #
  def get_rubbishes
    @player_vm.role.rubbish_bin.get_rubbishes
  end

  def get_nutrients
    @player_vm.role.nutrient_bin.get_nutrients
  end

  def get_pets
    @player_vm.role.pet_package.items
  end
  #
  # def get_eye_wears
  #   @player_vm.role.eye_wear_package.items
  # end
  #
  # def get_ear_wears
  #   @player_vm.role.ear_wear_package.items
  # end
  #
  # def get_wings
  #   @player_vm.role.wing_package.items
  # end
  #
  # def get_hats
  #   @player_vm.role.hat_package.items
  # end
  #
  # def get_underpans
  #   @player_vm.role.underpan_package.items
  # end
  #
  # def get_handhelds
  #   @player_vm.role.handheld_package.items
  # end

  def choose_equipment(equipment)
    @player_vm.equip(EquipmentViewModelFactory.create_equipment(equipment))
  end

  def choose_none_equipment(equipment_type)
    @player_vm.un_equip equipment_type
  end

  def choose_pet(pet)
    @player_vm.choose_pet pet
  end
end