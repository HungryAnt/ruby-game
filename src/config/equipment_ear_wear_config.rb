
lambda {
  ear_wear = 'ear_wear'

  create_ear_wear = lambda { |id, ver_nums_pair, hor_nums_pair|
    create_equipment_anims(ear_wear, id, down_nums_pair:ver_nums_pair,
                           up_nums_pair:ver_nums_pair, hor_nums_pair:hor_nums_pair)
    set_equipment_properties(ear_wear, id, left: [0, 0], up: [0, 0], down: [0, 0])
  }

  create_ear_wear.call 266, [0, 7], [8, 15]
  create_ear_wear.call 292, [0, 3], [4, 7]
  create_ear_wear.call 342, [0, 3], [4, 7]
  create_ear_wear.call 352, [0, 3], [4, 7]
  create_ear_wear.call 361, [0, 5], [6, 11]
  create_ear_wear.call 379, [0, 5], [6, 11]
  create_ear_wear.call 384, [0, 3], [4, 7]
  create_ear_wear.call 403, [0, 3], [4, 7]
  create_ear_wear.call 414, [0, 7], [8, 15]
  create_ear_wear.call 427, [0, 3], [4, 7]
  create_ear_wear.call 463, [0, 7], [8, 15]
}.call