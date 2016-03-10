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
  EquipmentDefinition.set_props key, offset: offset, height: body_height, speed_up: speed_up,
                                is_behind_role: options[:is_behind_role], is_cloak: options[:is_cloak],
                                miss: options[:miss]
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

# 灰机
create_vehicle_anims(58, hor_nums_pair:[5, 5], up_nums_pair:[2, 2], down_nums_pair:[0, 1])
set_vehicle_properties(58, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

# 浴缸
create_vehicle_anims(59, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(59, 1, 0.5, left: [0, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(67, hor_nums_pair:[10, 11], up_nums_pair:[8, 9], down_nums_pair:[0, 7])
set_vehicle_properties(67, 6, 0.5, left: [0, -11], up: [0, -10], down: [0, -6])

# 熊猫
create_vehicle_anims(74, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(74, 1, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

# 警车
create_vehicle_anims(75, hor_nums_pair:[12, 17], up_nums_pair:[6, 11], down_nums_pair:[0, 5])
set_vehicle_properties(75, 1, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(81, hor_nums_pair:[6, 9], up_nums_pair:[4, 5], down_nums_pair:[0, 3])
set_vehicle_properties(81, 3, 0.5, left: [-11, -7], up: [0, -7], down: [0, -6])

create_vehicle_anims(82, hor_nums_pair:[6, 8], up_nums_pair:[3, 5], down_nums_pair:[0, 2])
set_vehicle_properties(82, 1, 0.5, left: [-5, -7], up: [0, -7], down: [0, -7])

create_vehicle_anims(83, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(83, 6, 0.5, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle_anims(89, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(89, 8, 0.5, left: [-6, -4], up: [-1, -4], down: [-1, -4], miss: 0.3)

create_vehicle_anims(90, hor_nums_pair:[14, 19], up_nums_pair:[8, 13], down_nums_pair:[0, 7])
set_vehicle_properties(90, 10, 0.5, left: [-15, -7], up: [-1, -4], down: [-1, -4])

# 大鸟
create_vehicle_anims(91, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0, 1])
set_vehicle_properties(91, 10, 0.5, left: [-15, -4], up: [0, -12], down: [0, -4])

create_vehicle_anims(604, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(604, 10, 0.9, left: [-15, -20], up: [0, -10], down: [0, 0], miss: 0.25)

create_vehicle_anims(828, hor_nums_pair:[32, 47], up_nums_pair:[16, 31], down_nums_pair:[0,15])
set_vehicle_properties(828, 10, 0.8, left: [-3, -4], up: [0, -10], down: [0, 7])

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

# 赛车
create_vehicle_anims(114, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(114, 8, 0.6, left: [-13, -8], up: [0, -5], down: [0, -5])

create_vehicle_anims(115, hor_nums_pair:[14, 15], up_nums_pair:[6, 13], down_nums_pair:[0, 5])
set_vehicle_properties(115, 3, 0.5, left: [-5, -10], up: [0, -10], down: [0, -10])

create_vehicle_anims(119, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(119, 6, 0.6, left: [-5, -3], up: [0, 0], down: [0, 2])

create_vehicle_anims(121, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(121, 3, 0.6, left: [-8, -9], up: [0, -6], down: [0, -2])

# v0.9.0新增车辆

create_vehicle_anims(138, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(138, 6, 0.6, left: [-5, 0], up: [0, -3], down: [0, -2])

create_vehicle_anims(144, hor_nums_pair:[7, 9], up_nums_pair:[4, 6], down_nums_pair:[0, 3])
set_vehicle_properties(144, 12, 0.6, left: [1, -11], up: [-1, -5], down: [-1, -4])

create_vehicle_anims(228, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(228, 6, 0.6, left: [-5, -7], up: [0, -6], down: [0, -6])

create_vehicle_anims(301, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(301, 14, 0.6, left: [-13, -3], up: [0, -8], down: [0, -2])

create_vehicle_anims(402, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(402, 39, 0.8, left: [7, -15], up: [0, -12], down: [0, -12], miss: 0.3)

create_vehicle_anims(450, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(450, 50, 0.9, left: [7, 4], up: [0, 1], down: [0, 0], miss: 0.25)

create_vehicle_anims(552, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(552, 33, 0.6, left: [-4, -2], up: [0, -2], down: [0, 2], miss: 0.25)

create_vehicle_anims(558, hor_nums_pair:[20, 31], up_nums_pair:[12, 19], down_nums_pair:[0, 11])
set_vehicle_properties(558, 25, 0.6, left: [-24, -8], up: [0, -2], down: [0, 2], miss: 0.25)

create_vehicle_anims(569, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle_properties(569, 31, 0.6, left: [-4, 1], up: [0, 2], down: [0, 1])

# 滑雪车

create_vehicle_anims(163, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(163, 10, 0.6, left: [-9, -3], up: [-2, -6], down: [-3, -6])

create_vehicle_anims(220, hor_nums_pair:[8, 11], up_nums_pair:[4, 7], down_nums_pair:[0, 3])
set_vehicle_properties(220, 7, 0.6, left: [-5, 0], up: [0, -5], down: [-0, -5])



# ================== v1.0新车

create_vehicle_anims(321, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(321, 9, 0.6, down: [0, 0], up: [0, -3], left: [0, -4])

create_vehicle_anims(322, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(322, 9, 0.7, down: [0, 0], up: [0, -3], left: [0, 18])

create_vehicle_anims(326, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(326, 18, 0.6, down: [0, 0], up: [0, -3], left: [-32, -9])

create_vehicle_anims(327, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13]) # 战斗机
set_vehicle_properties(327, 27, 0.9, down: [0, 6], up: [0, 16], left: [-6, 10], miss: 0.30)

create_vehicle_anims(331, down_nums_pair:[0, 3], up_nums_pair:[4, 5], hor_nums_pair:[6, 9])
set_vehicle_properties(331, 18, 0.6, down: [0, 5], up: [0, 1], left: [-15, 7])

create_vehicle_anims(332, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(332, 18, 0.65, down: [0, -3], up: [0, -6], left: [-4, -5], miss: 0.25)

create_vehicle_anims(336, down_nums_pair:[16, 23], up_nums_pair:[0, 7], hor_nums_pair:[8, 15])
set_vehicle_properties(336, 9, 0.6, down: [0, -6], up: [0, -8], left: [10, -8], miss: 0.25)

create_vehicle_anims(340, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(340, 15, 0.7, down: [0, 5], up: [0, -6], left: [-9, -4], miss: 0.25)

create_vehicle_anims(345, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(345, 28, 0.6, down: [0, 5], up: [0, 4], left: [-12, 4])

create_vehicle_anims(346, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(346, 12, 0.6, down: [0, 0], up: [0, -2], left: [-12, -10])

create_vehicle_anims(354, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(354, 15, 0.7, down: [0, -3], up: [0, -6], left: [-9, -7], miss: 0.25)

create_vehicle_anims(359, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(359, 23, 0.7, down: [-1, -6], up: [-1, -9], left: [-9, -3],miss: 0.2)

# 重型坦克
create_vehicle_anims(521, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 19])
set_vehicle_properties(521, 28, 0.7, down: [-0.8, 0], up: [-1, -4], left: [-30, -1], miss: 0.50)

# 天启坦克
create_vehicle_anims(662, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(662, 32, 0.85, down: [0, -9], up: [-1, 8], left: [-16, -5], miss: 0.65)

create_vehicle_anims(802, down_nums_pair:[0, 10], up_nums_pair:[11, 22], hor_nums_pair:[23, 34])
set_vehicle_properties(802, 15, 0.92, down: [0, 4], up: [0, -6], left: [-14, -9], miss: 0.25)

# ------------------ 树叶
# create_vehicle_anims(234, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
# set_vehicle_properties(234, 6, 0.8, down: [0, -4], up: [0, -6], left: [0, -7], is_behind_role: true)

# ------------------ 木马
anim_nums_381 = [0, 3]
create_vehicle_anims(381, down_nums_pair:anim_nums_381, up_nums_pair:anim_nums_381, hor_nums_pair:anim_nums_381)
set_vehicle_properties(381, 22, 0.6, down: [-8, -10], up: [-8, -10], left: [-14, -10])

# ------------------ 圣诞节车辆
create_vehicle_anims(168, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(168, 6, 0.6, down: [0, -4], up: [0, -7], left: [-15, -3])

create_vehicle_anims(172, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(172, 5, 0.6, down: [0, -5], up: [0, -5], left: [2, -6])

create_vehicle_anims(178, down_nums_pair:[0, 3], up_nums_pair:[4, 5], hor_nums_pair:[6, 9])
set_vehicle_properties(178, 16, 0.6, down: [0, -7], up: [0, -13], left: [-20, -13])

create_vehicle_anims(188, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(188, 7, 0.6, down: [0, -2], up: [0, -5], left: [-5, -3])

create_vehicle_anims(222, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(222, 5, 0.6, down: [0, -9], up: [0, -9], left: [-5, -9])

create_vehicle_anims(710, down_nums_pair:[0, 11], up_nums_pair:[12, 19], hor_nums_pair:[20, 31])
set_vehicle_properties(710, 15, 0.6, down: [2, 5], up: [0, 3], left: [-28, -3])

create_vehicle_anims(711, down_nums_pair:[0, 11], up_nums_pair:[12, 19], hor_nums_pair:[20, 31])
set_vehicle_properties(711, 16, 0.6, down: [0, -3], up: [0, -7], left: [-20, -6])

# ------------------ 披风
create_vehicle_anims(433, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(433, 0, 0.6, down: [0, 12], up: [0, 8], left: [8, 8], is_cloak: true)

create_vehicle_anims(497, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(497, 0, 0.6, down: [0, 12], up: [0, 8], left: [10, 12], is_cloak: true)

create_vehicle_anims(514, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(514, 0, 0.9, down: [0, -5], up: [0, -1], left: [-5, 2], is_cloak: true, miss: 0.25)

create_vehicle_anims(574, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(574, 0, 0.6, down: [0, 14], up: [0, 6], left: [18, 10], is_cloak: true)

create_vehicle_anims(598, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(598, 0, 0.9, down: [0, 12], up: [0, 8], left: [6, 8], is_cloak: true, miss: 0.25)

create_vehicle_anims(708, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(708, 0, 0.9, down: [-3, -5], up: [-1, -2], left: [7, -7], is_cloak: true, miss: 0.25)

create_vehicle_anims(723, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(723, 0, 0.6, down: [-1, 2], up: [-1, 5], left: [16, -6], is_cloak: true)

# ----------------- 时装载具
create_vehicle_anims(697, down_nums_pair:[0, 9], up_nums_pair:[10, 19], hor_nums_pair:[20, 24])
set_vehicle_properties(697, 18, 0.9, down: [0, -20], up: [0, -20], left: [0, -20], miss: 0.3)

create_vehicle_anims(376, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(376, 18, 0.65, down: [-1, -2], up: [0, -3], left: [-15, -1])

create_vehicle_anims(456, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(456, 18, 0.65, down: [0, 3], up: [0, -3], left: [-6, 7])

create_vehicle_anims(439, down_nums_pair:[0, 15], up_nums_pair:[16, 17], hor_nums_pair:[18, 25])
set_vehicle_properties(439, 10, 0.9, down: [-1, -15], up: [-4, -7], left: [-1, -8], miss: 0.3)

# ----------------- 飞碟

create_vehicle_anims(192, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(192, 10, 0.7, down: [0, -12], up: [0, -11], left: [0, -13])

create_vehicle_anims(461, down_nums_pair:[0, 1], up_nums_pair:[2, 4], hor_nums_pair:[5, 5])
set_vehicle_properties(461, 26, 0.7, down: [0, 0], up: [0, 0], left: [0, 0])


# 1.1 新增车辆

create_vehicle_anims(125, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(125, 16, 0.7, down: [-1, 0], up: [-1, 0], left: [-13, 0])

create_vehicle_anims(126, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(126, 13, 0.7, down: [0, -12], up: [0, -12], left: [-15, -12])

create_vehicle_anims(127, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(127, 4, 0.7, down: [0, 3], up: [0, -2], left: [-18, -3])

create_vehicle_anims(132, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(132, 10, 0.7, down: [0, 1], up: [0, 0], left: [-14, -2])

create_vehicle_anims(133, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(133, 9, 0.7, down: [-1, -19], up: [0, -16], left: [-10, -19])

create_vehicle_anims(139, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(139, 7, 0.7, down: [0, 0], up: [0, 0], left: [-6, 0])

create_vehicle_anims(143, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(143, 6, 0.7, down: [0, -4], up: [0, -4], left: [0, -4])

create_vehicle_anims(148, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(148, 10, 0.7, down: [-1, -13], up: [0, -20], left: [-15, -22])

create_vehicle_anims(149, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(149, 6, 0.7, down: [0, -6], up: [0, -5], left: [-8, -3])

create_vehicle_anims(153, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(153, 14, 0.7, down: [0, -16], up: [0, -18], left: [-12, -18])

create_vehicle_anims(154, down_nums_pair:[0, 3], up_nums_pair:[4, 5], hor_nums_pair:[6, 9])
set_vehicle_properties(154, 10, 0.7, down: [0, 0], up: [0, 0], left: [0, 0])

create_vehicle_anims(159, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(159, 5, 0.7, down: [0, 0], up: [0, 0], left: [-8, 1])

create_vehicle_anims(160, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(160, 4, 0.7, down: [0, 0], up: [0, 0], left: [-15, 0])

create_vehicle_anims(167, down_nums_pair:[0, 5], up_nums_pair:[6, 7], hor_nums_pair:[8, 9])
set_vehicle_properties(167, 12, 0.7, down: [-2, -13], up: [-2, -17], left: [-10, -13])

create_vehicle_anims(173, down_nums_pair:[0, 1], up_nums_pair:[2, 3], hor_nums_pair:[4, 5])
set_vehicle_properties(173, 10, 0.7, down: [0, -8], up: [0, -10], left: [-10, -10])

create_vehicle_anims(177, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(177, 7, 0.7, down: [-1, -5], up: [0, -8], left: [-11, -2])

create_vehicle_anims(181, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(181, 7, 0.7, down: [0, 1], up: [0, -2], left: [-10, -1])

create_vehicle_anims(185, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(185, 10, 0.7, down: [0, 0], up: [0, -2], left: [-10, 0])

create_vehicle_anims(191, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(191, 8, 0.7, down: [0, 4], up: [0, 4], left: [-8, -1])

create_vehicle_anims(194, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(194, 8, 0.7, down: [0, 5], up: [-1, -3], left: [-10, 2])

create_vehicle_anims(195, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(195, 6, 0.7, down: [0, 0], up: [0, 0], left: [-11, 0])

create_vehicle_anims(198, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(198, 10, 0.7, down: [-1, 0], up: [0, -12], left: [-18, -10])

create_vehicle_anims(199, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(199, 8, 0.7, down: [0, 0], up: [0, -1], left: [-11, 0])

create_vehicle_anims(203, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(203, 10, 0.7, down: [0, -2], up: [0, -4], left: [-11, -4])

create_vehicle_anims(204, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(204, 6, 0.7, down: [0, 14], up: [0, 5], left: [-10, 3])

create_vehicle_anims(206, down_nums_pair:[0, 5], up_nums_pair:[6, 7], hor_nums_pair:[8, 13])
set_vehicle_properties(206, 10, 0.7, down: [0, 5], up: [0, -3], left: [-17, -6])

create_vehicle_anims(207, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(207, 5, 0.7, down: [0, 0], up: [0, 7], left: [-10, -10])

create_vehicle_anims(211, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(211, 8, 0.7, down: [0, -8], up: [0, -8], left: [-7, -8])

create_vehicle_anims(212, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(212, 10, 0.7, down: [1, -10], up: [1, -10], left: [0, -10])

create_vehicle_anims(216, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(216, 6, 0.7, down: [0, -6], up: [0, -6], left: [-1, -2])

create_vehicle_anims(217, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(217, 8, 0.7, down: [0, 0], up: [0, -2], left: [-15, 5])

create_vehicle_anims(221, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(221, 8, 0.7, down: [-1, -1], up: [0, 0], left: [-20, -5])

create_vehicle_anims(229, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(229, 5, 0.7, down: [0, 0], up: [0, 0], left: [-10, 0])

create_vehicle_anims(235, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(235, 7, 0.7, down: [0, 0], up: [0, 0], left: [-10, 0])

create_vehicle_anims(239, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 19])
set_vehicle_properties(239, 6, 0.7, down: [-1, 0], up: [-1, 0], left: [-6, 4])

create_vehicle_anims(240, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(240, 3, 0.7, down: [0, 2], up: [0, 0], left: [-10, 2])

create_vehicle_anims(244, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(244, 8, 0.7, down: [0, 1], up: [0, -2], left: [-9, 0])

create_vehicle_anims(245, down_nums_pair:[0, 7], up_nums_pair:[8, 13], hor_nums_pair:[14, 21])
set_vehicle_properties(245, 6, 0.7, down: [0, 2], up: [0, 17], left: [-10, -4])

# ------------------------------------

create_vehicle_anims(249, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(249, 5, 0.7, down: [0, 6], up: [0, 0], left: [-15, -2])

create_vehicle_anims(250, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(250, 7, 0.7, down: [2, 0], up: [0, 0], left: [-8, -10])

create_vehicle_anims(254, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(254, 10, 0.7, down: [-1, -5], up: [-1, -5], left: [0, -2])

create_vehicle_anims(255, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 15])
set_vehicle_properties(255, 7, 0.7, down: [0, 0], up: [0, -5], left: [-14, 0])

create_vehicle_anims(259, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 15])
set_vehicle_properties(259, 7, 0.7, down: [0, 4], up: [0, 3], left: [-12, 4])

create_vehicle_anims(260, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(260, 7, 0.7, down: [0, 0], up: [0, 0], left: [-10, -3])

create_vehicle_anims(264, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(264, 8, 0.7, down: [0, 0], up: [0, -2], left: [-9, -3])

create_vehicle_anims(265, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(265, 7, 0.7, down: [0, 0], up: [0, -3], left: [-11, -2])

create_vehicle_anims(269, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(269, 7, 0.7, down: [0, 1], up: [0, 0], left: [-8, -3])

create_vehicle_anims(270, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 19])
set_vehicle_properties(270, 10, 0.7, down: [1, 2], up: [0, -8], left: [-14, 1])

create_vehicle_anims(274, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(274, 20, 0.7, down: [0, 2], up: [0, -0], left: [0, 3])

create_vehicle_anims(275, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(275, 10, 0.7, down: [0, -10], up: [0, -10], left: [0, -10])

create_vehicle_anims(279, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(279, 9, 0.7, down: [-2, 14], up: [-2, 8], left: [-31, 0])

create_vehicle_anims(280, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(280, 10, 0.7, down: [0, -1], up: [0, -3], left: [-14, -10])

create_vehicle_anims(285, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(285, 7, 0.7, down: [0, 0], up: [0, 0], left: [-10, -5])

create_vehicle_anims(286, down_nums_pair:[0, 15], up_nums_pair:[16, 19], hor_nums_pair:[20, 35])
set_vehicle_properties(286, 10, 0.7, down: [0, 7], up: [0, 0], left: [-25, 5])

create_vehicle_anims(290, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 23])
set_vehicle_properties(290, 7, 0.7, down: [-2, -6], up: [-2, -6], left: [0, -6])

create_vehicle_anims(291, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 15])
set_vehicle_properties(291, 7, 0.7, down: [0, 2], up: [0, 2], left: [-12, -5])

create_vehicle_anims(295, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(295, 10, 0.7, down: [0, -13], up: [0, -13], left: [-2, -13])

create_vehicle_anims(296, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(296, 20, 0.7, down: [0, -5], up: [0, 17], left: [-8, 14])

create_vehicle_anims(300, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(300, 10, 0.7, down: [0, 2], up: [0, 0], left: [-14, -2])

# create_vehicle_anims(000, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
# set_vehicle_properties(000, 10, 0.7, down: [0, 0], up: [0, 0], left: [0, 0])

# > 1.1.1

create_vehicle_anims(305, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(305, 9, 0.7, down: [0, -2], up: [0, 0], left: [-2, -2])

create_vehicle_anims(306, down_nums_pair:[0, 7], up_nums_pair:[8, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(306, 21, 0.7, down: [0, 13], up: [0, 13], left: [-5, 2])

create_vehicle_anims(310, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(310, 8, 0.7, down: [0, 2], up: [0, 2], left: [-5, -6])

create_vehicle_anims(311, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(311, 9, 0.7, down: [0, 3], up: [0, 0], left: [-10, -6])

create_vehicle_anims(314, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(314, 9, 0.7, down: [0, -3], up: [0, 0], left: [-12, -5])

create_vehicle_anims(315, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 13])
set_vehicle_properties(315, 9, 0.7, down: [0, 5], up: [0, 0], left: [-10, -5])

create_vehicle_anims(320, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(320, 9, 0.7, down: [0, 0], up: [0, 0], left: [-9, -5])

create_vehicle_anims(337, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(337, 15, 0.7, down: [0, 9], up: [0, 0], left: [0, 0])

create_vehicle_anims(341, down_nums_pair:[0, 13], up_nums_pair:[14, 27], hor_nums_pair:[28, 41])
set_vehicle_properties(341, 16, 0.7, down: [0, 15], up: [0, 15], left: [-18, 10])

create_vehicle_anims(350, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(350, 22, 0.7, down: [2, 13], up: [2, 10], left: [-6, 9])

create_vehicle_anims(351, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(351, 30, 0.7, down: [-1, 0], up: [-1, 4], left: [-9, 0])

create_vehicle_anims(353, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(353, 9, 0.7, down: [0, 0], up: [0, 0], left: [0, 0])

create_vehicle_anims(360, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(360, 33, 0.7, down: [-1, 3], up: [0, 3], left: [0, 5])

create_vehicle_anims(364, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(364, 22, 0.7, down: [0, 9], up: [0, 0], left: [-11, -6])

create_vehicle_anims(365, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(365, 9, 0.7, down: [-9, 6], up: [-8, 6], left: [0, 6])

create_vehicle_anims(367, down_nums_pair:[0, 3], up_nums_pair:[0, 3], hor_nums_pair:[4, 7])
set_vehicle_properties(367, 7, 0.7, down: [-6, -6], up: [-6, -6], left: [0, -6])

create_vehicle_anims(368, down_nums_pair:[0, 5], up_nums_pair:[6, 7], hor_nums_pair:[8, 13])
set_vehicle_properties(368, 12, 0.7, down: [0, 9], up: [0, 0], left: [-13, -2])

create_vehicle_anims(372, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(372, 10, 0.7, down: [0, 8], up: [0, 2], left: [-10, -4])

create_vehicle_anims(373, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 19])
set_vehicle_properties(373, 10, 0.7, down: [0, 12], up: [0, 2], left: [-17, -1])

create_vehicle_anims(377, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(377, 33, 0.7, down: [-1, 14], up: [-1, 14], left: [-21, 0])

create_vehicle_anims(382, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(382, 12, 0.7, down: [0, 0], up: [0, 0], left: [-9, -4])

create_vehicle_anims(387, down_nums_pair:[0, 5], up_nums_pair:[6, 11], hor_nums_pair:[12, 17])
set_vehicle_properties(387, 13, 0.7, down: [0, -6], up: [0, -6], left: [-3, -6])

create_vehicle_anims(388, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(388, 25, 0.7, down: [0, -6], up: [0, -6], left: [0, -22])

# ----------

create_vehicle_anims(393, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(393, 27, 0.7, down: [0, -5], up: [0, -5], left: [-5, -12])

create_vehicle_anims(396, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(396, 25, 0.7, down: [0, -9], up: [0, -9], left: [-8, -10])

create_vehicle_anims(397, down_nums_pair:[0, 5], up_nums_pair:[6, 9], hor_nums_pair:[10, 15])
set_vehicle_properties(397, 40, 0.7, down: [0, 0], up: [0, 0], left: [-8, 0])

create_vehicle_anims(401, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(401, 9, 0.7, down: [0, -3], up: [0, -3], left: [0, -3])

create_vehicle_anims(406, down_nums_pair:[0, 3], up_nums_pair:[4, 7], hor_nums_pair:[8, 11])
set_vehicle_properties(406, 23, 0.7, down: [0, 0], up: [0, 0], left: [-5, -3])

create_vehicle_anims(407, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
set_vehicle_properties(407, 13, 0.7, down: [0, 6], up: [0, -3], left: [-3, -4])

create_vehicle_anims(410, down_nums_pair:[0, 7], up_nums_pair:[8, 15], hor_nums_pair:[16, 23])
set_vehicle_properties(410, 6, 0.7, down: [0, -3], up: [0, 0], left: [22, 0])

# 斗篷
# create_vehicle_anims(412, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
# set_vehicle_properties(412, 9, 0.7, down: [0, -6], up: [0, -6], left: [0, -22])

create_vehicle_anims(748, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(748, 26, 0.7, down: [-2, -3], up: [-2, -5], left: [0, -3])

create_vehicle_anims(749, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(749, 9, 0.7, down: [0, -6], up: [0, 0], left: [0, -4])

create_vehicle_anims(753, down_nums_pair:[0, 15], up_nums_pair:[16, 27], hor_nums_pair:[28, 43])
set_vehicle_properties(753, 20, 0.7, down: [0, -15], up: [0, -17], left: [35, -17])

create_vehicle_anims(754, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(754, 14, 0.7, down: [0, -1], up: [0, -4], left: [-4, -8])

create_vehicle_anims(758, down_nums_pair:[0, 9], up_nums_pair:[10, 19], hor_nums_pair:[20, 29])
set_vehicle_properties(758, 18, 0.7, down: [0, 0], up: [0, -2], left: [-12, -9])

create_vehicle_anims(759, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(759, 20, 0.7, down: [1, -1], up: [0, -2], left: [-28, -1])

create_vehicle_anims(764, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(764, 15, 0.7, down: [0, 14], up: [-1, 0], left: [0, -12])

create_vehicle_anims(768, down_nums_pair:[0, 15], up_nums_pair:[16, 31], hor_nums_pair:[32, 47])
set_vehicle_properties(768, 24, 0.7, down: [2, -3], up: [0, -5], left: [24, -5])

create_vehicle_anims(773, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(773, 9, 0.7, down: [0, 9], up: [0, 6], left: [-5, -5])

create_vehicle_anims(779, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(779, 14, 0.7, down: [3, -1], up: [2, 0-1], left: [-6, -7])

create_vehicle_anims(780, down_nums_pair:[0, 9], up_nums_pair:[10, 19], hor_nums_pair:[20, 29])
set_vehicle_properties(780, 35, 0.7, down: [0, -1], up: [0, -1], left: [-4, 0])

create_vehicle_anims(785, down_nums_pair:[0, 9], up_nums_pair:[10, 19], hor_nums_pair:[20, 29])
set_vehicle_properties(785, 33, 0.7, down: [-1, 2], up: [-1, -8], left: [0, -12])

create_vehicle_anims(788, down_nums_pair:[0, 11], up_nums_pair:[12, 23], hor_nums_pair:[24, 35])
set_vehicle_properties(788, 14, 0.7, down: [0, 5], up: [0, 2], left: [0, 0])

# create_vehicle_anims(, down_nums_pair:[0, 7], up_nums_pair:[8, 11], hor_nums_pair:[12, 15])
# set_vehicle_properties(, 9, 0.7, down: [0, 0], up: [0, 0], left: [0, 0])


# ================== 怀旧车辆
create_vehicle2_anims(10, hor_nums_pair:[2, 2], up_nums_pair:[1, 1], down_nums_pair:[0, 0])
set_vehicle2_properties(10, 3, 0.6, left: [-5, -4], up: [0, -4], down: [0, -4])

create_vehicle2_anims(24, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
set_vehicle2_properties(24, 6, 0.6, left: [-5, -4], up: [-2, -4], down: [-2, -4])

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
set_vehicle2_properties(69, 7, 0.75, left: [-11, -7], up: [0, -4], down: [0, 7])

create_vehicle2_anims(119, hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_vehicle2_properties(119, 10, 0.75, left: [-28, 18], up: [0, 17], down: [0, 21])

create_dragon_anims('DragonRed', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonRed', 95, 3, left: [-10, -50], up: [0, -50], down: [0, -38])

create_dragon_anims('DragonBlack', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonBlack', 95, 3, left: [-10, -50], up: [0, -50], down: [0, -38])

create_dragon_anims('DragonBlue', hor_nums_pair:[20, 29], up_nums_pair:[10, 19], down_nums_pair:[0, 9])
set_dragon_properties('DragonBlue', 95, 3, left: [-10, -50], up: [0, -50], down: [0, -38])

