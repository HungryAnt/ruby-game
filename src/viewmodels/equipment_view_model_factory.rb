class EquipmentViewModelFactory
  def self.create_car(num)
    equipment_vm = EquipmentViewModel.new("car_#{num}", 10)
    equipment_vm
  end
end