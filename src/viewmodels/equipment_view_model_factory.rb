class EquipmentViewModelFactory
  def self.create_equipment(equipment)
    equipment_vm = EquipmentViewModel.new(equipment)
    equipment_vm
  end

  def self.create_equipment_from_key(equipment_type, key)
    equipment = Equipment.new equipment_type, key.to_sym
    equipment_vm = EquipmentViewModel.new(equipment)
    equipment_vm
  end
end