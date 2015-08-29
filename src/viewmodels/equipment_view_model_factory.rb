class EquipmentViewModelFactory
  def self.create_equipment(equipment)
    case equipment.type
      when Equipment::Type::VEHICLE
        return create_vehicle(equipment.key)
    end
  end

  def self.create_vehicle(key)
    equipment_vm = EquipmentViewModel.new(key, 10)
    equipment_vm
  end
end