def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

lambda {
  anim_interval = 150

  # ================角色动画================

  role_info_list = []
  role_info_list << [RoleType::WAN_GYE, 'WanGye']
  role_info_list << [RoleType::SALARY, 'Salary']
  role_info_list << [RoleType::BANGYE, 'BanGye']
  role_info_list << [RoleType::DOOBU, 'Doobu']
  role_info_list << [RoleType::KIMCHI, 'Kimchi']
  role_info_list << [RoleType::MANL, 'Manl']
  role_info_list << [RoleType::MOO, 'Moo']
  role_info_list << [RoleType::PASERY, 'Pasery']
  role_info_list << [RoleType::PIMENTO, 'Pimento']
  role_info_list << [RoleType::RICE, 'Rice']
  role_info_list << [RoleType::YANGBEA, 'Yangbea']
  role_info_list << [RoleType::YANGPA, 'Yangpa']

  def new_role_anims(prefix, pattern, action, anim_nums_map, anim_interval=150)
    AnimationManager.new_centered_anims prefix do
      hor_nums = to_anim_nums(*anim_nums_map[:hor_nums_pair])
      up_nums = to_anim_nums(*anim_nums_map[:up_nums_pair])
      down_nums = to_anim_nums(*anim_nums_map[:down_nums_pair])
      {
          "#{action}_left".to_sym => [pattern, hor_nums, anim_interval],
          "#{action}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
          "#{action}_up".to_sym => [pattern, up_nums, anim_interval],
          "#{action}_down".to_sym => [pattern, down_nums, anim_interval]
      }
    end
  end

  role_info_list.each do |role_info|
    role = role_info[0].to_s
    role_pattern = "role/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    role_action_pattern = "role_action/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    prefix = "#{role}_"

    new_role_anims(prefix, role_pattern, 'walk', hor_nums_pair:[30, 34], up_nums_pair:[20, 24], down_nums_pair:[5, 9])
    new_role_anims(prefix, role_pattern, 'stand', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4])
    new_role_anims(prefix, role_pattern, 'run', hor_nums_pair:[50, 54], up_nums_pair:[45, 49], down_nums_pair:[40, 44])
    new_role_anims(prefix, role_pattern, 'eat', hor_nums_pair:[65, 69], up_nums_pair:[60, 64], down_nums_pair:[55, 59])
    new_role_anims(prefix, role_pattern, 'hold_food', hor_nums_pair:[76, 78], up_nums_pair:[73, 75], down_nums_pair:[70, 72])
    new_role_anims(prefix, role_pattern, 'drive', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4]) # 动画与stand一致
    new_role_anims(prefix, role_action_pattern, 'turn_to_battered', hor_nums_pair:[168, 169], up_nums_pair:[162, 163], down_nums_pair:[156, 157]) # 正被打扁
    new_role_anims(prefix, role_action_pattern, 'battered', hor_nums_pair:[170, 173], up_nums_pair:[164, 167], down_nums_pair:[158, 161]) # 打扁的

    AnimationManager.new_centered_anims prefix do
      h_nums = [151, 152, 153, 154]
      up_nums = [147, 148, 149, 150]
      down_nums = [141, 142, 143, 144]
      {
          :hit_left => [role_action_pattern, h_nums, anim_interval, 1, 1, [-27, -13]],
          :hit_right => [role_action_pattern, h_nums, anim_interval, -1, 1, [27, -13]],
          :hit_up => [role_action_pattern, up_nums, anim_interval],
          :hit_down => [role_action_pattern, down_nums, anim_interval]
      }
    end
  end

  # ================地面点击动画================
  AnimationManager.new_centered_anim(:area_click) do
    pattern = 'ui/click/CursorShadow_${num}.bmp'
    nums = 0.upto(6)
    [pattern, nums, 120]
  end

  # ================鼠标开门动画================

  AnimationManager.new_centered_anim(:goto_area) do
    pattern = 'ui/cursor/CurSor_${num}.bmp'
    nums = [1, 2, 3, 2]
    [pattern, nums, 200]
  end

  # ================ map covering ================

  def new_map_covering_anim(key, pattern, first_num, last_num, interval = 200, reverse_anim = true)
    AnimationManager.new_anim(key) do
      nums = reverse_anim ? to_anim_nums(first_num, last_num): [*(first_num..last_num)]
      images = AnimationUtil.get_images(pattern, nums)
      AnimationUtil.get_animation images, interval
    end
  end

  new_map_covering_anim(:church_outside_cat, 'map/church/outside/cat_${num}.bmp', 0, 2, 300)

  new_map_covering_anim(:school_ground_children, 'map/school/school_ground/children_${num}.bmp', 1, 12)

  new_map_covering_anim(:police_policeman, 'map/police/man_${num}.bmp', 0, 5, 300)
  new_map_covering_anim(:police_tv, 'map/police/tv_${num}.bmp', 0, 8)

  # house_roof1
  pattern_house_roof1 = 'map/house/roof1/HouseTop_${num}.bmp'
  new_map_covering_anim(:house_roof1_right_birds, pattern_house_roof1, 1, 6)
  new_map_covering_anim(:house_roof1_left_birds, pattern_house_roof1, 7, 13)
  new_map_covering_anim(:house_roof1_cat_1, pattern_house_roof1, 14, 21)
  new_map_covering_anim(:house_roof1_cat_2, pattern_house_roof1, 22, 27, 250)
  new_map_covering_anim(:house_roof1_cat_2_eye, pattern_house_roof1, 28, 31, 500)
  new_map_covering_anim(:house_roof1_cat_3, pattern_house_roof1, 32, 42)

  # house_roof2
  pattern_house_roof2 = 'map/house/roof2/HouseTop2_${num}.bmp'
  new_map_covering_anim(:house_roof2_birds, pattern_house_roof2, 3, 12)

  # house_bottom
  pattern_house_bottom = 'map/house/bottom/HouseBottom_${num}.bmp'
  new_map_covering_anim(:house_bottom_frog, pattern_house_bottom, 4, 8, 400)
  new_map_covering_anim(:house_bottom_bucket, pattern_house_bottom, 9, 18, 150, false)

  # house_kitchen_outside
  pattern_house_kitchen_outside = 'map/house/kitchen_outside/KitchenOutside_${num}.bmp'
  new_map_covering_anim(:house_kitchen_door, pattern_house_kitchen_outside, 3, 16, 200)

  # house_kitchen_inside
  pattern_house_kitchen_inside = 'map/house/kitchen_inside/KitchenInside_${num}.bmp'
  new_map_covering_anim(:house_kitchen_sink, pattern_house_kitchen_inside, 3, 5, 150, false)
  new_map_covering_anim(:house_kitchen_pot, pattern_house_kitchen_inside, 6, 10, 150, false)
  new_map_covering_anim(:house_kitchen_fire, pattern_house_kitchen_inside, 11, 13, 150, false)

  # seven_star_hall
  pattern_seven_star_hall = 'map/seven_star_hall/SevenStartHall_${num}.bmp'
  new_map_covering_anim(:hall_left_lantern, pattern_seven_star_hall, 3, 10)
  new_map_covering_anim(:hall_right_lantern, pattern_seven_star_hall, 11, 18)
  new_map_covering_anim(:hall_immortal, pattern_seven_star_hall, 19, 26)

  # channel_main
  pattern_channel_anim = 'channel_main/anim/ChannelAni_${num}.bmp'
  new_map_covering_anim(:channel_main_vegetable, pattern_channel_anim, 28, 33)
  new_map_covering_anim(:channel_main_cows, pattern_channel_anim, 2, 5)
  new_map_covering_anim(:channel_main_sky_wheel, pattern_channel_anim, 10, 19, 150, false)
  new_map_covering_anim(:channel_main_waterfall, pattern_channel_anim, 24, 27, 150, false)
}.call