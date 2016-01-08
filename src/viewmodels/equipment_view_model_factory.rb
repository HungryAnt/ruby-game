class EquipmentViewModelFactory
  def self.create_equipment(equipment)
    case equipment.type
      when Equipment::Type::VEHICLE
        return create_vehicle(equipment.key)
      when Equipment::Type::EYE_WEAR
        return create_common_equipment(equipment)
      when Equipment::Type::WING
        return create_common_equipment(equipment)
      when Equipment::Type::HAT
        return create_common_equipment(equipment)
    end
  end

  def self.create_equipment_from_key(equipment_type, key)
    equipment = Equipment.new equipment_type, key.to_sym
    equipment_vm = EquipmentViewModel.new(equipment)
    equipment_vm
  end

  def self.create_vehicle(key)
    equipment_vm = VehicleViewModel.new(key)
    equipment_vm
  end

  def self.create_common_equipment(equipment)
    equipment_vm = EquipmentViewModel.new(equipment)
    equipment_vm
  end
end