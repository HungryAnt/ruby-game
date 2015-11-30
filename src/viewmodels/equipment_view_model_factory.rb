class EquipmentViewModelFactory
  def self.create_equipment(equipment)
    case equipment.type
      when Equipment::Type::VEHICLE
        return create_vehicle(equipment.key)
      when Equipment::Type::EYE_WEAR
        return create_eye_wear(equipment)
    end
  end

  def self.create_vehicle(key)
    equipment_vm = VehicleViewModel.new(key)
    equipment_vm
  end

  def self.create_eye_wear(equipment)
    equipment_vm = EquipmentViewModel.new(equipment)
    equipment_vm
  end
end