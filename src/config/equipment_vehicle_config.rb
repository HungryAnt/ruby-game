# def to_one_way_anim_nums(first_num, last_num)
#   (first_num..last_num).to_a
# end

def create_vehicle_anims(vehicle_id, anim_nums_map, vehicle='vehicle')
  anim_interval = 150
  AnimationManager.new_centered_anims '' do
    pattern = "#{vehicle}/#{vehicle_id}/#{vehicle_id}_${num}.bmp"
    hor_nums = to_anim_nums(*anim_nums_map[:hor_nums_pair])
    up_nums = to_anim_nums(*anim_nums_map[:up_nums_pair])
    down_nums = to_anim_nums(*anim_nums_map[:down_nums_pair])
    {
        "#{vehicle}_#{vehicle_id}_left".to_sym => [pattern, hor_nums, anim_interval],
        "#{vehicle}_#{vehicle_id}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
        "#{vehicle}_#{vehicle_id}_up".to_sym => [pattern, up_nums, anim_interval],
        "#{vehicle}_#{vehicle_id}_down".to_sym => [pattern, down_nums, anim_interval]
    }
  end
end

def set_vehicle_properties(id, body_height, speed_up, offset, vehicle='vehicle')
  key = "#{vehicle}_#{id}".to_sym
  offset_left = offset[:left]
  offset[:right] = [-offset_left[0], offset_left[1]]
  EquipmentDefinition.set_props key, offset:offset, body_height:body_height, speed_up:speed_up
  EquipmentDefinition.set_item_image key, "#{vehicle}/#{id}/#{id}_0.bmp"
end

def create_vehicle2_anims(vehicle_id, anim_nums_map)
  create_vehicle_anims vehicle_id, anim_nums_map, 'vehicle2'
end

def set_vehicle2_properties(id, body_height, speed_up, offset)
  set_vehicle_properties id, body_height, speed_up, offset, 'vehicle2'
end

def create_dragon_anims(dragon, anim_nums_map)
  create_vehicle_anims dragon, anim_nums_map, 'dragon'
end

def set_dragon_properties(id, body_height, speed_up, offset)
  set_vehicle_properties id, body_height, speed_up, offset, 'dragon'
end

create_vehicle_anims(39, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(39, 3, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(40, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(40, 3, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(50, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(50, 3, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

# »Ò»ú
create_vehicle_anims(58, hor_nums_pair:[5, 5], up_nums_pair:[2, 2], down_nums_pair:[0, 1])
set_vehicle_properties(58, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

# Ô¡¸×
create_vehicle_anims(59, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(59, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(67, hor_nums_pair:[10, 11], up_nums_pair:[8, 9], down_nums_pair:[0, 7])
set_vehicle_properties(67, 6, 0.5, left: [0, -11], up: [0, -10], down: [0, -6])

# ÐÜÃ¨
create_vehicle_anims(74, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(74, 1, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

# ¾¯³µ
create_vehicle_anims(75, hor_nums_pair:[12, 17], up_nums_pair:[6, 11], down_nums_pair:[0, 5])
set_vehicle_properties(75, 1, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(81, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(81, 3, 0.5, left: [-11, -7], up: [0, -7], down: [0, -6])

create_vehicle_anims(82, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(82, 1, 0.5, left: [-5, -7], up: [0, -7], down: [0, -7])

create_vehicle_anims(83, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(83, 6, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(89, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(89, 8, 0.5, left: [-6, -4], up: [-1, -4], down: [-1, -4])

create_vehicle_anims(90, hor_nums_pair:[14, 19], up_nums_pair:[8, 13], down_nums_pair:[0, 7])
set_vehicle_properties(90, 10, 0.5, left: [-15, -7], up: [-1, -4], down: [-1, -4])

# ´óÄñ
create_vehicle_anims(91, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(91, 10, 0.5, left: [-15, -4], up: [0, -12], down: [0, -4])

create_vehicle_anims(604, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(604, 10, 1.3, left: [-15, -20], up: [0, -10], down: [0, 0])

create_vehicle_anims(828, hor_nums_pair:[32, 47], up_nums_pair:[16, 31], down_nums_pair:[0,15])
set_vehicle_properties(828, 10, 1.0, left: [-3, -4], up: [0, -10], down: [0, 7])

# ----v0.5.1
create_vehicle_anims(96, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(96, 10, 0.5, left: [-5, -4], up: [0, -12], down: [0, -4])

create_vehicle_anims(97, hor_nums_pair:[4, 7], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(97, 10, 0.5, left: [-3, -4], up: [-1, -12], down: [-1, -4])

create_vehicle_anims(103, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(103, 6, 0.5, left: [-7, -7], up: [15, -12], down: [15, -4])

create_vehicle_anims(104, hor_nums_pair:[14, 21], up_nums_pair:[8, 13], down_nums_pair:[0, 7])
set_vehicle_properties(104, 10, 0.5, left: [-15, -4], up: [-1, 2], down: [0, 3])

create_vehicle_anims(108, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(108, 10, 0.5, left: [-1, -4], up: [0, -12], down: [1, -4])

create_vehicle_anims(109, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(109, 16, 0.6, left: [-1, 7], up: [0, -5], down: [-1, -5])

# Èü³µ
create_vehicle_anims(114, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(114, 8, 0.6, left: [-13, -8], up: [0, -5], down: [0, -5])

create_vehicle_anims(115, hor_nums_pair:[14, 15], up_nums_pair:[6, 13], down_nums_pair:[0, 5])
set_vehicle_properties(115, 3, 0.5, left: [-5, -10], up: [0, -10], down: [0, -10])

create_vehicle_anims(119, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(119, 6, 0.6, left: [-5, -3], up: [0, 0], down: [0, 2])

create_vehicle_anims(121, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(121, 3, 0.6, left: [-8, -9], up: [0, -6], down: [0, -2])

# »³¾É³µÁ¾
create_vehicle2_anims(10, hor_nums_pair:[2, 2], up_nums_pair:[1, 1], down_nums_pair:[0, 0])
set_vehicle2_properties(10, 3, 0.7, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle2_anims(24, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle2_properties(24, 6, 0.7, left: [-5, -4], up: [-2, -4], down: [-2, -4])

create_vehicle2_anims(26, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle2_properties(26, 6, 0.5, left: [-4, -4], up: [-0.5, -4], down: [-0.5, -4])

create_vehicle2_anims(35, hor_nums_pair:[4, 7], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle2_properties(35, 3, 0.5, left: [-11, -7], up: [0, -5], down: [0, -3])

create_vehicle2_anims(39, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle2_properties(39, 6, 0.5, left: [-5, -4], up: [0, 0], down: [0, 0])

create_vehicle2_anims(41, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle2_properties(41, 5, 0.5, left: [-11, -3], up: [0, -5], down: [0, 0])

create_vehicle2_anims(43, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle2_properties(43, 6, 0.5, left: [-11, -7], up: [0, -3], down: [0, 2])

create_vehicle2_anims(69, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle2_properties(69, 7, 0.8, left: [-11, -7], up: [0, -4], down: [0, 7])

create_vehicle2_anims(119, hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_vehicle2_properties(119, 10, 0.8, left: [-28, 18], up: [0, 17], down: [0, 21])

create_dragon_anims('DragonRed', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonRed', 95, 3.5, left: [-10, -50], up: [0, -50], down: [0, -38])

create_dragon_anims('DragonBlack', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonBlack', 95, 5.5, left: [-10, -50], up: [0, -50], down: [0, -38])

create_dragon_anims('DragonBlue', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonBlue', 95, 4.5, left: [-10, -50], up: [0, -50], down: [0, -38])

