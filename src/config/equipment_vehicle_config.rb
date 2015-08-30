def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

def create_vehicle_anims(vehicle_id, anim_nums_map)
  anim_interval = 150
  AnimationManager.new_centered_anims '' do
    pattern = "vehicle/#{vehicle_id}/#{vehicle_id}_${num}.bmp"
    hor_nums = to_anim_nums(*anim_nums_map[:hor_nums_pair])
    up_nums = to_anim_nums(*anim_nums_map[:up_nums_pair])
    down_nums = to_anim_nums(*anim_nums_map[:down_nums_pair])
    {
        "vehicle_#{vehicle_id}_left".to_sym => [pattern, hor_nums, anim_interval],
        "vehicle_#{vehicle_id}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
        "vehicle_#{vehicle_id}_up".to_sym => [pattern, up_nums, anim_interval],
        "vehicle_#{vehicle_id}_down".to_sym => [pattern, down_nums, anim_interval]
    }
  end
end

def set_vehicle_properties(id, body_height, offset)
  key = "vehicle_#{id}".to_sym
  offset_left = offset[:left]
  offset[:right] = [-offset_left[0], offset_left[1]]
  EquipmentDefinition.set_location_offset(key, offset)
  EquipmentDefinition.set_body_height key, body_height
  EquipmentDefinition.set_item_image(key, "vehicle/#{id}/#{id}_0.bmp")
end

create_vehicle_anims(39, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(39, 3, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(40, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(40, 3, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(50, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(50, 3, left: [-5, -4], up: [0, -4], down: [0, -4])

# »Ò»ú
create_vehicle_anims(58, hor_nums_pair:[5, 5], up_nums_pair:[2, 2], down_nums_pair:[0, 1])
set_vehicle_properties(58, 1, left: [0, -4], up: [0, -4], down: [0, -4])

# Ô¡¸×
create_vehicle_anims(59, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(59, 1, left: [0, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(67, hor_nums_pair:[10, 11], up_nums_pair:[8, 9], down_nums_pair:[0, 7])
set_vehicle_properties(67, 6, left: [0, -11], up: [0, -10], down: [0, -6])

# ÐÜÃ¨
create_vehicle_anims(74, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(74, 1, left: [-5, -4], up: [0, -4], down: [0, -4])

# ¾¯³µ
create_vehicle_anims(75, hor_nums_pair:[12, 17], up_nums_pair:[6, 11], down_nums_pair:[0, 5])
set_vehicle_properties(75, 1, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(81, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(81, 3, left: [-11, -7], up: [0, -7], down: [0, -6])

create_vehicle_anims(82, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(82, 1, left: [-5, -7], up: [0, -7], down: [0, -7])

create_vehicle_anims(83, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(83, 6, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(89, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(89, 8, left: [-6, -4], up: [-1, -4], down: [-1, -4])

create_vehicle_anims(90, hor_nums_pair:[14, 19], up_nums_pair:[8, 13], down_nums_pair:[0, 7])
set_vehicle_properties(90, 10, left: [-15, -7], up: [-1, -4], down: [-1, -4])

# ´óÄñ
create_vehicle_anims(91, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(91, 10, left: [-15, -4], up: [0, -12], down: [0, -4])

create_vehicle_anims(604, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(604, 10, left: [-15, -20], up: [0, -10], down: [0, 0])

create_vehicle_anims(828, hor_nums_pair:[32, 47], up_nums_pair:[16, 31], down_nums_pair:[0,15])
set_vehicle_properties(828, 10, left: [-3, -4], up: [0, -10], down: [0, 7])