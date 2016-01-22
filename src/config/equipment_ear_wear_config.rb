
lambda {
  ear_wear = 'ear_wear'

  create_ear_wear = lambda { |id, ver_nums_pair, hor_nums_pair, offsets={}|
    create_equipment_anims(ear_wear, id, down_nums_pair:ver_nums_pair,
                           up_nums_pair:ver_nums_pair, hor_nums_pair:hor_nums_pair)
    left = offsets.include?(:left) ? offsets[:left] : [0, 0]
    up = offsets.include?(:up) ? offsets[:up] : [0, 0]
    down = offsets.include?(:down) ? offsets[:down] : [0, 0]
    set_equipment_properties(ear_wear, id, left: left, up: up, down: down)
  }

  create_ear_wear.call 266, [0, 7], [8, 15], down:[0, 1], left:[-5, 2]
  create_ear_wear.call 292, [0, 3], [4, 7], down:[0, 2], left:[-5, -4]
  create_ear_wear.call 342, [0, 3], [4, 7], down:[0, 15], up:[0, 15], left:[0, 15]
  create_ear_wear.call 352, [0, 3], [4, 7], down:[0, 8], up:[0, 9], left:[-14, 8]
  create_ear_wear.call 361, [0, 5], [6, 11], down:[0, 12], up:[0, 12], left:[0, 12]
  create_ear_wear.call 379, [0, 5], [6, 11], down:[-1, 20], up:[-1, 20], left:[0, 18]
  create_ear_wear.call 384, [0, 3], [4, 7], down:[0, 19], up:[0, 19], left:[0, 18]
  create_ear_wear.call 403, [0, 3], [4, 7], down:[0, 6], up:[0, 6], left:[-6, 4]
  create_ear_wear.call 414, [0, 7], [8, 15], down:[0, 5], up:[0, 5], left:[2, 6]
  create_ear_wear.call 427, [0, 3], [4, 7], down:[0, -2], up:[0, -2], left:[0, -2]
  create_ear_wear.call 463, [0, 7], [8, 15], down:[0, 7], up:[0, 7], left:[0, 7]
}.call