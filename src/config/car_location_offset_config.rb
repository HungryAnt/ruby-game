def set_car_properties(id, body_height, offset)
  key = "car_#{id}".to_sym
  offset_left = offset[:left]
  offset[:right] = [-offset_left[0], offset_left[1]]
  EquipmentDefinition.set_location_offset(key, offset)
  EquipmentDefinition.set_body_height key, body_height
  EquipmentDefinition.set_item_image(key, "car/#{id}/#{id}_0.bmp")
end

set_car_properties(604, 10, left: [-15, -20], up: [0, -10], down: [0, 0])
set_car_properties(828, 10, left: [-3, -4], up: [0, -10], down: [0, 7])
set_car_properties(39, 1, left: [-5, 0], up: [0, 0], down: [0, 0])
set_car_properties(40, 1, left: [-5, 0], up: [0, 0], down: [0, 0])