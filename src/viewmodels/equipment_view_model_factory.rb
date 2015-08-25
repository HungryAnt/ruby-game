class EquipmentViewModelFactory
  def self.create_vehicle(num)
    equipment_vm = EquipmentViewModel.new("car_#{num}".to_sym, 10)
    equipment_vm
  end

  def self.from_model(equipment)

  end
end