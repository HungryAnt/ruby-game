def to_one_way_anim_nums(first_num, last_num)
  (first_num..last_num).to_a
end

def create_vehicle_anims(vehicle_id, anim_nums_map, vehicle='vehicle')
  anim_interval = 150
  AnimationManager.new_centered_anims '' do
    pattern = "#{vehicle}/#{vehicle_id}/#{vehicle_id}_${num}.bmp"
    hor_nums = to_one_way_anim_nums(*anim_nums_map[:hor_nums_pair])
    up_nums = to_one_way_anim_nums(*anim_nums_map[:up_nums_pair])
    down_nums = to_one_way_anim_nums(*anim_nums_map[:down_nums_pair])
    {
        "#{vehicle}_#{vehicle_id}_left".to_sym => [pattern, hor_nums, anim_interval],
        "#{vehicle}_#{vehicle_id}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
        "#{vehicle}_#{vehicle_id}_up".to_sym => [pattern, up_nums, anim_interval],
        "#{vehicle}_#{vehicle_id}_down".to_sym => [pattern, down_nums, anim_interval]
    }
  end
end

def set_vehicle_properties(id, body_height, speed_up, options, vehicle='vehicle')
  key = "#{vehicle}_#{id}".to_sym
  offset = {}
  offset[:left] = options[:left]
  offset[:up] = options[:up]
  offset[:down] = options[:down]
  offset_left = offset[:left]
  offset[:right] = [-offset_left[0], offset_left[1]]
  EquipmentDefinition.set_props key, offset:offset, body_height:body_height, speed_up:speed_up,
                                is_behind_role: options[:is_behind_role], is_cloak: options[:is_cloak]
  EquipmentDefinition.set_item_image key, "#{vehicle}/#{id}/#{id}_0.bmp"
end

def create_vehicle2_anims(vehicle_id, anim_nums_map)
  create_vehicle_anims vehicle_id, anim_nums_map, 'vehicle2'
end

def set_vehicle2_properties(id, body_height, speed_up, options)
  set_vehicle_properties id, body_height, speed_up, options, 'vehicle2'
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

# �һ�
create_vehicle_anims(58, hor_nums_pair:[5, 5], up_nums_pair:[2, 2], down_nums_pair:[0, 1])
set_vehicle_properties(58, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

# ԡ��
create_vehicle_anims(59, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(59, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(67, hor_nums_pair:[10, 11], up_nums_pair:[8, 9], down_nums_pair:[0, 7])
set_vehicle_properties(67, 6, 0.5, left: [0, -11], up: [0, -10], down: [0, -6])

# ��è
create_vehicle_anims(74, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(74, 1, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

# ����
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

# ����
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

# ����
create_vehicle_anims(114, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(114, 8, 0.6, left: [-13, -8], up: [0, -5], down: [0, -5])

create_vehicle_anims(115, hor_nums_pair:[14, 15], up_nums_pair:[6, 13], down_nums_pair:[0, 5])
set_vehicle_properties(115, 3, 0.5, left: [-5, -10], up: [0, -10], down: [0, -10])

create_vehicle_anims(119, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(119, 6, 0.6, left: [-5, -3], up: [0, 0], down: [0, 2])

create_vehicle_anims(121, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(121, 3, 0.6, left: [-8, -9], up: [0, -6], down: [0, -2])

# v0.9.0��������

create_vehicle_anims(138, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(138, 6, 0.8, left: [-5, 0], up: [0, -3], down: [0, -2])

create_vehicle_anims(144, hor_nums_pair:[7, 9], up_nums_pair:[4, 6], down_nums_pair:[0, 3])
set_vehicle_properties(144, 12, 0.8, left: [1, -11], up: [-1, -5], down: [-1, -4])

create_vehicle_anims(228, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(228, 6, 0.8, left: [-5, -7], up: [0, -6], down: [0, -6])

create_vehicle_anims(301, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(301, 14, 0.8, left: [-13, -3], up: [0, -8], down: [0, -2])

create_vehicle_anims(402, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(402, 39, 1.0, left: [7, -15], up: [0, -12], down: [0, -12])

create_vehicle_anims(450, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(450, 50, 1.3, left: [7, 4], up: [0, 1], down: [0, 0])

create_vehicle_anims(552, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(552, 33, 0.8, left: [-4, -2], up: [0, -2], down: [0, 2])

create_vehicle_anims(558, hor_nums_pair:[20, 31], up_nums_pair:[12, 19], down_nums_pair:[0, 11])
set_vehicle_properties(558, 25, 0.8, left: [-24, -8], up: [0, -2], down: [0, 2])

create_vehicle_anims(569, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(569, 31, 0.8, left: [-4, 1], up: [0, 2], down: [0, 1])

# ��ѩ��

create_vehicle_anims(163, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(163, 10, 0.8, left: [-9, -3], up: [-2, -6], down: [-3, -6])

create_vehicle_anims(220, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(220, 7, 0.8, left: [-5, 0], up: [0, -5], down: [-0, -5])



# ================== v1.0�³�

create_vehicle_anims(321, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(321, 9, 0.8, down: [0, 0], up: [0, -3], left: [0, -4])

create_vehicle_anims(322, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(322, 9, 0.8, down: [0, 0], up: [0, -3], left: [0, 18])

create_vehicle_anims(326, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(326, 18, 0.8, down: [0, 0], up: [0, -3], left: [-32, -9])

create_vehicle_anims(327, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(327, 27, 1.3, down: [0, 6], up: [0, 16], left: [-6, 10])

create_vehicle_anims(331, down_nums_pair:[0, 3], up_nums_pair:[4, 5], hor_nums_pair:[6, 9])
set_vehicle_properties(331, 18, 0.8, down: [0, 5], up: [0, 1], left: [-15, 7])

create_vehicle_anims(332, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(332, 18, 0.8, down: [0, -3], up: [0, -6], left: [-4, -5])

create_vehicle_anims(336, down_nums_pair:[16, 23], up_nums_pair:[0, 7], hor_nums_pair:[8, 15])
set_vehicle_properties(336, 9, 0.8, down: [0, -6], up: [0, -8], left: [10, -8])

create_vehicle_anims(340, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(340, 15, 0.8, down: [0, 5], up: [0, -6], left: [-9, -4])

create_vehicle_anims(345, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(345, 28, 0.8, down: [0, 5], up: [0, 4], left: [-12, 4])

create_vehicle_anims(346, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(346, 12, 0.8, down: [0, 0], up: [0, -2], left: [-12, -10])

create_vehicle_anims(354, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(354, 15, 0.8, down: [0, -3], up: [0, -6], left: [-9, -7])

create_vehicle_anims(359, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(359, 23, 0.8, down: [-1, -6], up: [-1, -9], left: [-9, -3])

# ����̹��
create_vehicle_anims(521, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 19])
set_vehicle_properties(521, 28, 0.8, down: [-0.8, 0], up: [-1, -4], left: [-30, -1])

# ����̹��
create_vehicle_anims(662, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(662, 32, 0.8, down: [0, -9], up: [-1, 8], left: [-16, -5])

create_vehicle_anims(802, down_nums_pair:[0, 10], up_nums_pair:[11, 22], hor_nums_pair:[23, 34])
set_vehicle_properties(802, 15, 0.8, down: [0, 4], up: [0, -6], left: [-14, -9])

# ------------------ ��Ҷ
# create_vehicle_anims(234, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
# set_vehicle_properties(234, 6, 0.8, down: [0, -4], up: [0, -6], left: [0, -7], is_behind_role: true)

# ------------------ ľ��
anim_nums_381 = [0, 3]
create_vehicle_anims(381, down_nums_pair:anim_nums_381, up_nums_pair:anim_nums_381, hor_nums_pair:anim_nums_381)
set_vehicle_properties(381, 22, 0.8, down: [-8, -10], up: [-8, -10], left: [-14, -10])

# ------------------ ʥ���ڳ���
create_vehicle_anims(168, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(168, 6, 0.8, down: [0, -4], up: [0, -7], left: [-15, -3])

create_vehicle_anims(172, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(172, 5, 0.8, down: [0, -5], up: [0, -5], left: [2, -6])

create_vehicle_anims(178, down_nums_pair:[0, 3], up_nums_pair:[4, 5], hor_nums_pair:[6, 9])
set_vehicle_properties(178, 16, 0.8, down: [0, -7], up: [0, -13], left: [-20, -13])

create_vehicle_anims(188, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(188, 7, 0.8, down: [0, -2], up: [0, -5], left: [-5, -3])

create_vehicle_anims(222, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(222, 5, 0.8, down: [0, -9], up: [0, -9], left: [-5, -9])

create_vehicle_anims(710, down_nums_pair:[0, 11], up_nums_pair:[12, 19], hor_nums_pair:[20, 31])
set_vehicle_properties(710, 15, 0.8, down: [2, 5], up: [0, 3], left: [-28, -3])

create_vehicle_anims(711, down_nums_pair:[0, 11], up_nums_pair:[12, 19], hor_nums_pair:[20, 31])
set_vehicle_properties(711, 16, 0.8, down: [0, -3], up: [0, -7], left: [-20, -6])

# ------------------ ����
create_vehicle_anims(433, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(433, 0, 0.8, down: [0, 12], up: [0, 8], left: [8, 8], is_cloak: true)

create_vehicle_anims(497, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(497, 0, 0.8, down: [0, 12], up: [0, 8], left: [10, 12], is_cloak: true)

create_vehicle_anims(514, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(514, 0, 0.8, down: [0, -5], up: [0, -1], left: [-5, 2], is_cloak: true)

create_vehicle_anims(574, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(574, 0, 0.8, down: [0, 14], up: [0, 6], left: [18, 10], is_cloak: true)

create_vehicle_anims(598, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(598, 0, 0.8, down: [0, 12], up: [0, 8], left: [6, 8], is_cloak: true)

create_vehicle_anims(708, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(708, 0, 0.8, down: [-3, -5], up: [-1, -2], left: [7, -7], is_cloak: true)

create_vehicle_anims(723, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(723, 0, 0.8, down: [-1, 2], up: [-1, 5], left: [16, -6], is_cloak: true)

# ----------------- ʱװ�ؾ�
create_vehicle_anims(697, down_nums_pair:[0, 9], up_nums_pair:[10, 19], hor_nums_pair:[20, 24])
set_vehicle_properties(697, 18, 0.8, down: [0, -20], up: [0, -20], left: [0, -20])

create_vehicle_anims(376, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(376, 18, 0.8, down: [-1, -2], up: [0, -3], left: [-15, -1])

create_vehicle_anims(456, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(456, 18, 0.8, down: [0, 3], up: [0, -3], left: [-6, 7])

create_vehicle_anims(439, down_nums_pair:[0, 15], up_nums_pair:[16, 17], hor_nums_pair:[18, 25])
set_vehicle_properties(439, 10, 0.8, down: [-1, -15], up: [-4, -7], left: [-1, -8])

# ================== ���ɳ���
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

