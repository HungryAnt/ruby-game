
lambda {
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

  # church
  new_map_covering_anim(:church_inside_window, 'map/church/inside/X-Mas00_ChurchIn_${num}.bmp', 4, 6, 150, false)
  new_map_covering_anim(:church_inside_treetop, 'map/church/inside/X-Mas00_ChurchIn_${num}.bmp', 8, 15, 150)
  new_map_covering_anim(:church_inside_bear, 'map/church/inside/X-Mas00_ChurchIn_${num}.bmp', 16, 23, 150)

  # snow_village
  new_map_covering_anim(:snow_village_2_rill,
                        'map/snow_village/snow_village_2/SnowFlowerVillage2_${num}.bmp', 5, 7, 150)

  new_map_covering_anim(:snow_village_3_rill,
                        'map/snow_village/snow_village_3/SnowFlowerVillage3_${num}.bmp', 6, 8, 150, false)

  new_map_covering_anim(:snow_village_4_fire,
                        'map/snow_village/snow_village_4/SnowFlowerVillage4_${num}.bmp', 6, 9, 150, false)

  new_map_covering_anim(:snow_village_5_left_candle,
                        'map/snow_village/snow_village_5/SnowFlowerVillage5_${num}.bmp', 5, 9, 150, false)

  new_map_covering_anim(:snow_village_5_right_candle,
                        'map/snow_village/snow_village_5/SnowFlowerVillage5_${num}.bmp', 10, 14, 150, false)

  # river_side
  new_map_covering_anim(:river_side_lobster,
                        'map/river_side/Riverside_${num}.bmp', 13, 16, 150, false)

  new_map_covering_anim(:river_side_fish, 'map/river_side/Riverside_${num}.bmp', 9, 12, 150)
  new_map_covering_anim(:river_side_tortoises, 'map/river_side/Riverside_${num}.bmp', 5, 6, 150, false)
  new_map_covering_anim(:river_side_tortoise, 'map/river_side/Riverside_${num}.bmp', 7, 8, 150, false)

  # port
  new_map_covering_anim(:port_ships, 'map/port/port/Port_${num}.bmp', 19, 30, 150, false)
  new_map_covering_anim(:port_wave, 'map/port/port/Port_${num}.bmp', 7, 18, 150, false)

  new_map_covering_anim(:ship_deck_boat, 'map/port/ship_deck/ShipDeck_${num}.bmp', 4, 9, 150, false)
  new_map_covering_anim(:ship_deck_right_octopus, 'map/port/ship_deck/ShipDeck_${num}.bmp', 10, 12, 150, false)
  new_map_covering_anim(:ship_deck_left_octopus, 'map/port/ship_deck/ShipDeck_${num}.bmp', 13, 21, 150, false)

  # pool
  pattern_pool_1 = 'map/pool/pool_1/Pool_${num}.bmp'
  new_map_covering_anim(:pool_1_element_1, pattern_pool_1, 30, 35, 150, false)
  new_map_covering_anim(:pool_1_element_2, pattern_pool_1, 36, 41, 150, false)
  new_map_covering_anim(:pool_1_element_3, pattern_pool_1, 42, 47, 150, false)
  new_map_covering_anim(:pool_1_element_4, pattern_pool_1, 48, 53, 150, false)
  new_map_covering_anim(:pool_1_flower, pattern_pool_1, 54, 58, 150, false)

  pattern_pool_2 = 'map/pool/pool_2/Pool2_${num}.bmp'
  new_map_covering_anim(:pool_2_water_1, pattern_pool_2, 7, 12, 150, false)
  new_map_covering_anim(:pool_2_water_2, pattern_pool_2, 13, 17, 150, false)
  new_map_covering_anim(:pool_2_water_3, pattern_pool_2, 18, 20, 150, false)
  new_map_covering_anim(:pool_2_rabbit_1, pattern_pool_2, 21, 25, 200, false)
  new_map_covering_anim(:pool_2_rabbit_2, pattern_pool_2, 26, 35, 200, false)

  # xiujuan house
  pattern_xiujuan_house_1 = 'map/xiujuan_house/hall_wooden/HallWooden_${num}.bmp'
  new_map_covering_anim(:xiujuan_house_1_dogs, pattern_xiujuan_house_1, 2, 15, 200, false)

  pattern_xiujuan_house_2 = 'map/xiujuan_house/garret_room/GarretRoom_${num}.bmp'
  new_map_covering_anim(:xiujuan_house_2_droplight, pattern_xiujuan_house_2, 2, 16, 200, false)
  new_map_covering_anim(:xiujuan_house_2_sunshine, pattern_xiujuan_house_2, 17, 31, 200, false)

  pattern_xiujuan_house_3 = 'map/xiujuan_house/inner_room/InnerRoom_${num}.bmp'
  new_map_covering_anim(:xiujuan_house_3_old_man, pattern_xiujuan_house_3, 15, 19, 300)

  # amusement_park
  pattern_amusement_park_1 = 'map/amusement_park/amusement_park_1/AmusementPark1_${num}.bmp'
  new_map_covering_anim(:amusement_park_1_flag, pattern_amusement_park_1, 3, 8, 200, false)
  # new_map_covering_anim(:amusement_park_1_wheel, pattern_amusement_park_1, 10, 15, 200, false)

  pattern_amusement_park_2 = 'map/amusement_park/amusement_park_2/AmusementPark2_${num}.bmp'
  new_map_covering_anim(:amusement_park_2_wheel, pattern_amusement_park_2, 4, 9, 200, false)
  new_map_covering_anim(:amusement_park_2_train, pattern_amusement_park_2, 10, 17, 200, false)

  pattern_amusement_park_3 = 'map/amusement_park/amusement_park_3/AmusementPark3_${num}.bmp'
  new_map_covering_anim(:amusement_park_3_lion, pattern_amusement_park_3, 13, 20, 200, false)
  new_map_covering_anim(:amusement_park_3_giraffe, pattern_amusement_park_3, 5, 12, 200, false) # 长颈鹿
  new_map_covering_anim(:amusement_park_3_monkeys, pattern_amusement_park_3, 21, 28, 200, false)
  new_map_covering_anim(:amusement_park_3_elephant, pattern_amusement_park_3, 29, 36, 200, false)
  new_map_covering_anim(:amusement_park_3_waterfall, pattern_amusement_park_3, 38, 39, 200, false)

  # chess
  pattern_chess = 'map/chess/Back_${num}.bmp'
  new_map_covering_anim(:chess_ship_men, pattern_chess, 20, 24, 200, false)
  new_map_covering_anim(:chess_ice_1, pattern_chess, 25, 28, 200, false)
  new_map_covering_anim(:chess_ice_2, pattern_chess, 29, 32, 200, false)
  new_map_covering_anim(:chess_ice_3, pattern_chess, 33, 36, 200, false)
  new_map_covering_anim(:chess_ice_4, pattern_chess, 37, 40, 200, false)
  new_map_covering_anim(:chess_ice_5, pattern_chess, 41, 44, 200, false)

  # picnic
  pattern_picnic_1 = 'map/picnic/picnic1/Picnic1_${num}.bmp'
  new_map_covering_anim(:picnic_1_bridge, pattern_picnic_1, 3, 5, 200, false)

  pattern_picnic_2 = 'map/picnic/picnic2/Picnic2_${num}.bmp'
  new_map_covering_anim(:picnic_2_tortoise, pattern_picnic_2, 4, 7, 200, false)

  # colliery
  pattern_colliery_1 = 'map/colliery/colliery1/Colliery1_${num}.bmp'
  new_map_covering_anim(:colliery_1_lamp, pattern_colliery_1, 4, 7, 200, false)

  pattern_colliery_2 = 'map/colliery/colliery2/Colliery2_${num}.bmp'
  new_map_covering_anim(:colliery_2_miner, pattern_colliery_2, 5, 9, 200, false)

  pattern_colliery_3 = 'map/colliery/colliery3/Colliery3_${num}.bmp'
  new_map_covering_anim(:colliery_3_traffic_light, pattern_colliery_3, 6, 7, 500, false)

  pattern_colliery_5 = 'map/colliery/colliery5/Colliery5_${num}.bmp'
  new_map_covering_anim(:colliery_5_traffic_light, pattern_colliery_5, 5, 6, 400, false)

  # hunting
  pattern_hunting_0 = 'map/hunting/hunting_0/Hunting_0_${num}.bmp'
  new_map_covering_anim(:hunting_0_water_1, pattern_hunting_0, 9, 11, 200, false)
  new_map_covering_anim(:hunting_0_water_2, pattern_hunting_0, 12, 14, 200, false)

  pattern_hunting_1 = 'map/hunting/hunting_1/Hunting_1_${num}.bmp'
  new_map_covering_anim(:hunting_1_fire_1, pattern_hunting_1, 7, 9, 200, false)
  new_map_covering_anim(:hunting_1_fire_2, pattern_hunting_1, 10, 15, 200, false)
  new_map_covering_anim(:hunting_1_fire_3, pattern_hunting_1, 16, 21, 200, false)
  new_map_covering_anim(:hunting_1_lamp, pattern_hunting_1, 22, 27, 200, false)

  pattern_hunting_2 = 'map/hunting/hunting_2/Hunting_2_${num}.bmp'
  new_map_covering_anim(:hunting_2_fire, pattern_hunting_2, 4, 9, 200, false)

  # circus
  pattern_circus_0 = 'map/circus/circus_0/Circus_0_${num}.bmp'
  new_map_covering_anim(:circus_0_flag, pattern_circus_0, 5, 7, 200, false)

  pattern_circus_1 = 'map/circus/circus_1/Circus_1_${num}.bmp'
  new_map_covering_anim(:circus_1_fire_1, pattern_circus_1, 6, 15, 200, false)
  new_map_covering_anim(:circus_1_fire_2, pattern_circus_1, 16, 25, 200, false)
  new_map_covering_anim(:circus_1_fire_3, pattern_circus_1, 26, 35, 200, false)

}.call