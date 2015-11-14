

def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

def to_simple_anim_nums(first_num, last_num)
  (first_num..last_num).to_a
end

lambda {
  anim_interval = 150

  # ================角色动画================

  role_info_list = []
  role_info_list << [RoleType::WAN_GYE, 'WanGye']
  role_info_list << [RoleType::SALARY, 'Salary', :img249] # 标记有img249的图片都多了一张210图片
  role_info_list << [RoleType::BANGYE, 'BanGye']
  role_info_list << [RoleType::DOOBU, 'Doobu']
  role_info_list << [RoleType::KIMCHI, 'Kimchi']
  role_info_list << [RoleType::MANL, 'Manl', :img249]
  role_info_list << [RoleType::MOO, 'Moo', :img249]
  role_info_list << [RoleType::PASERY, 'Pasery', :img249]
  role_info_list << [RoleType::PIMENTO, 'Pimento']
  role_info_list << [RoleType::RICE, 'Rice']
  role_info_list << [RoleType::YANGBEA, 'Yangbea', :img249]
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

  def new_role_anims_with_same_imgs(prefix, pattern, action, raw_img_nums, anim_interval=150, reversed=true)
    AnimationManager.new_centered_anims prefix do
      if reversed
        img_nums = to_anim_nums(*raw_img_nums)
      else
        img_nums = to_simple_anim_nums(*raw_img_nums)
      end
      {
          "#{action}_left".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_right".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_up".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_down".to_sym => [pattern, img_nums, anim_interval]
      }
    end
  end

  role_info_list.each do |role_info|
    role = role_info[0].to_s
    role_pattern = "role/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    role_action_pattern = "role_action/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    prefix = "#{role}_"
    img249 = role_info[2] == :img249

    new_role_anims(prefix, role_pattern, 'walk', hor_nums_pair:[30, 34], up_nums_pair:[20, 24], down_nums_pair:[5, 9])
    new_role_anims(prefix, role_pattern, 'stand', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4])
    new_role_anims(prefix, role_pattern, 'run', hor_nums_pair:[50, 54], up_nums_pair:[45, 49], down_nums_pair:[40, 44])
    new_role_anims(prefix, role_pattern, 'eat', hor_nums_pair:[65, 69], up_nums_pair:[60, 64], down_nums_pair:[55, 59])
    new_role_anims(prefix, role_pattern, 'hold_food', hor_nums_pair:[76, 78], up_nums_pair:[73, 75], down_nums_pair:[70, 72])
    new_role_anims(prefix, role_pattern, 'drive', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4]) # 动画与stand一致
    new_role_anims(prefix, role_action_pattern, 'turn_to_battered', hor_nums_pair:[168, 169], up_nums_pair:[162, 163], down_nums_pair:[156, 157]) # 正被打扁
    new_role_anims(prefix, role_action_pattern, 'battered', hor_nums_pair:[170, 173], up_nums_pair:[164, 167], down_nums_pair:[158, 161]) # 打扁的

    new_role_anims(prefix, role_action_pattern, 'scare', hor_nums_pair:[10, 14], up_nums_pair:[5, 9], down_nums_pair:[0, 4]) # 惊吓
    new_role_anims(prefix, role_action_pattern, 'lecherous', hor_nums_pair:[25, 29], up_nums_pair:[20, 24], down_nums_pair:[15, 19]) # 好色
    new_role_anims(prefix, role_action_pattern, 'bye', hor_nums_pair:[40, 44], up_nums_pair:[35, 39], down_nums_pair:[30, 34])
    new_role_anims(prefix, role_action_pattern, 'cry', hor_nums_pair:[55, 59], up_nums_pair:[50, 54], down_nums_pair:[45, 49])
    new_role_anims(prefix, role_action_pattern, 'laugh', hor_nums_pair:[70, 74], up_nums_pair:[65, 69], down_nums_pair:[60, 63])
    new_role_anims(prefix, role_action_pattern, 'finger_hit', hor_nums_pair:[85, 89], up_nums_pair:[80, 84], down_nums_pair:[75, 79])
    new_role_anims(prefix, role_action_pattern, 'turn_to_finger_battered', hor_nums_pair:[104, 108], up_nums_pair:[97, 101], down_nums_pair:[90, 94])
    new_role_anims(prefix, role_action_pattern, 'finger_battered', hor_nums_pair:[109, 110], up_nums_pair:[102, 103], down_nums_pair:[95, 96])
    new_role_anims(prefix, role_action_pattern, 'fart', hor_nums_pair:[121, 125], up_nums_pair:[116, 120], down_nums_pair:[111, 115])
    new_role_anims(prefix, role_action_pattern, 'head_hit', hor_nums_pair:[136, 140], up_nums_pair:[131, 135], down_nums_pair:[126, 130])
    new_role_anims(prefix, role_action_pattern, 'turn_to_stunned', hor_nums_pair:[188, 194], up_nums_pair:[181, 187], down_nums_pair:[174, 180]) # 正被击晕

    new_role_anims_with_same_imgs(prefix, role_action_pattern, 'stunned', [195, 202]) # 晕了


    arrogant_anim_interval = 250
    worry_anim_interval = 250
    happy_anim_interval = 250
    roll_anim_interval = 200
    sleep_anim_interval = 350
    if img249
      # 投掷（魔法球）
      new_role_anims(prefix, role_action_pattern, 'cast', hor_nums_pair:[216, 220], up_nums_pair:[211, 215], down_nums_pair:[205, 209])
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'arrogant', [221, 225], arrogant_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'worry', [226, 230], worry_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'happy', [231, 235], happy_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'roll', [236, 244], roll_anim_interval, false)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'sleep', [245, 249], sleep_anim_interval)
    else
      new_role_anims(prefix, role_action_pattern, 'cast', hor_nums_pair:[215, 219], up_nums_pair:[210, 214], down_nums_pair:[205, 209])
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'arrogant', [220, 224], arrogant_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'worry', [225, 229], worry_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'happy', [230, 234], happy_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'roll', [235, 243], roll_anim_interval, false)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'sleep', [244, 248], sleep_anim_interval)
    end

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

    AnimationManager.new_centered_anims prefix do
      h_nums = [85, 86, 87]
      up_nums = [82, 83, 84]
      down_nums = [79, 80, 81]
      {
          :collecting_rubbish_left => [role_pattern, h_nums, anim_interval, 1, 1, [8, 0]],
          :collecting_rubbish_right => [role_pattern, h_nums, anim_interval, -1, 1, [-8, 0]],
          :collecting_rubbish_up => [role_pattern, up_nums, anim_interval],
          :collecting_rubbish_down => [role_pattern, down_nums, anim_interval]
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

  def new_map_covering_anim(key, pattern, first_num, last_num, interval=200, reverse_anim=true)
    AnimationManager.new_anim(key) do
      nums = reverse_anim ? to_anim_nums(first_num, last_num): [*(first_num..last_num)]
      images = AnimationUtil.get_images(pattern, nums)
      AnimationUtil.get_animation images, interval
    end
  end

  def set_animation_delay(key, delay)
    anim = AnimationManager.get_anim key
    anim.delay = delay
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

  # cart
  pattern_cart = 'map/cart/Cart_${num}.bmp'
  new_map_covering_anim(:cart_wheel, pattern_cart, 6, 18, 150, false)

  # ghost_house_0
  pattern_ghost_house_0 = 'map/ghost_house/ghost_house_0/GhostHouse0_${num}.bmp'
  new_map_covering_anim(:ghost_house_0_well, pattern_ghost_house_0, 27, 38)
  set_animation_delay(:ghost_house_0_well, 13000)
  new_map_covering_anim(:ghost_house_0_ghost_old_man, pattern_ghost_house_0, 2, 26, 200, false)
  set_animation_delay(:ghost_house_0_ghost_old_man, 8000)
  new_map_covering_anim(:ghost_house_0_ghost_woman, pattern_ghost_house_0, 39, 42, 250, false)

  # ghost_house_1
  pattern_ghost_house_1 = 'map/ghost_house/ghost_house_1/GhostHouse1_${num}.bmp'
  new_map_covering_anim(:ghost_house_1_left_ghost, pattern_ghost_house_1, 14, 25)
  set_animation_delay(:ghost_house_1_left_ghost, 7000)
  new_map_covering_anim(:ghost_house_1_right_old_man, pattern_ghost_house_1, 3, 13)
  set_animation_delay(:ghost_house_1_right_old_man, 10000)
  new_map_covering_anim(:ghost_house_1_right_women, pattern_ghost_house_1, 26, 38, 200, false)
  set_animation_delay(:ghost_house_1_right_women, 13000)

  # ghost_house_2
  pattern_ghost_house_2 = 'map/ghost_house/ghost_house_2/GhostHouse2_${num}.bmp'
  new_map_covering_anim(:ghost_house_2_ghost_boy, pattern_ghost_house_2, 4, 9)
  set_animation_delay(:ghost_house_2_ghost_boy, 12000)
  new_map_covering_anim(:ghost_house_2_palm, pattern_ghost_house_2, 10, 16)
  set_animation_delay(:ghost_house_2_palm, 8000)
  new_map_covering_anim(:ghost_house_2_head, pattern_ghost_house_2, 17, 24)
  set_animation_delay(:ghost_house_2_head, 18000)

  # henhouse
  pattern_henhouse_outside = 'map/henhouse/henhouse_outside/ChickenHouse_${num}.bmp'
  new_map_covering_anim(:henhouse_outside_left_two_hens, pattern_henhouse_outside, 1, 19)
  new_map_covering_anim(:henhouse_outside_hens_tails, pattern_henhouse_outside, 20, 38)
  new_map_covering_anim(:henhouse_outside_right_hen, pattern_henhouse_outside, 39, 57)

  pattern_henhouse_inside = 'map/henhouse/henhouse_inside/HenhouseInside_${num}.bmp'
  new_map_covering_anim(:henhouse_inside_two_hens, pattern_henhouse_inside, 1, 19)
  new_map_covering_anim(:henhouse_inside_one_hens, pattern_henhouse_inside, 20, 32)

  pattern_henhouse_back_garden = 'map/henhouse/henhouse_back_garden/HenhouseBackGarden_${num}.bmp'
  new_map_covering_anim(:henhouse_back_garden_dragonfly, pattern_henhouse_back_garden, 3, 10)

  pattern_henhouse_cow_cage = 'map/henhouse/henhouse_cow_cage/CowCage_${num}.bmp'
  new_map_covering_anim(:henhouse_cow_cage_cat, pattern_henhouse_cow_cage, 4, 11, 200, false)
  new_map_covering_anim(:henhouse_cow_cage_left_cow, pattern_henhouse_cow_cage, 24, 34, 200, false)
  new_map_covering_anim(:henhouse_cow_cage_middle_cow, pattern_henhouse_cow_cage, 35, 41, 200, false)
  new_map_covering_anim(:henhouse_cow_cage_right_cow, pattern_henhouse_cow_cage, 12, 23, 200, false)

  # rainy_day
  pattern_rainy_day_1 = 'map/rainy_day/rainy_day_1/RainyDay1_${num}.bmp'
  new_map_covering_anim(:rainy_day_1_rain, pattern_rainy_day_1, 3, 8, 150, false)

  pattern_rainy_day_2 = 'map/rainy_day/rainy_day_2/RainyDay2_${num}.bmp'
  new_map_covering_anim(:rainy_day_2_rain, pattern_rainy_day_2, 2, 5, 150, false)

  # channel_main
  pattern_channel_anim = 'channel_main/anim/ChannelAni_${num}.bmp'
  new_map_covering_anim(:channel_main_vegetable, pattern_channel_anim, 28, 33)
  new_map_covering_anim(:channel_main_cows, pattern_channel_anim, 2, 5)
  new_map_covering_anim(:channel_main_sky_wheel, pattern_channel_anim, 10, 19, 150, false)
  new_map_covering_anim(:channel_main_waterfall, pattern_channel_anim, 24, 27, 150, false)

  # waste_station
  new_map_covering_anim(:waste_clerk, 'map/waste_station/WasteMesh_${num}.bmp', 1, 8, 450, false)
}.call