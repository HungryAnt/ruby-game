lambda {
  def new_monster_anims(prefix, pattern, options={})
    new_direction_anims prefix, pattern, 'stand',
                        hor_nums_pair: options[:stand_hor],
                        up_nums_pair: options[:stand_up],
                        down_nums_pair: options[:stand_down],
                        anim_interval: 250

    new_direction_anims prefix, pattern, 'move',
                        hor_nums_pair: options[:move_hor],
                        up_nums_pair: options[:move_up],
                        down_nums_pair: options[:move_down],
                        need_down_right_anim: true

    new_direction_anims prefix, pattern, 'attack',
                        hor_nums_pair: options[:attack_hor],
                        up_nums_pair: options[:attack_up],
                        down_nums_pair: options[:attack_down],
                        anim_interval: 250,
                        reversed: false

    new_direction_anims prefix, pattern, 'capitulate',
                        hor_nums_pair: options[:capitulate],
                        up_nums_pair: options[:capitulate],
                        down_nums_pair: options[:capitulate],
                        anim_interval: 250,
                        reversed: false
  end

  def new_village_monster_anims(id, options={})
    monster_id = "monster_#{id}"
    prefix = "#{monster_id}_"
    pattern = "monster/#{id}/#{id}_${num}.bmp"
    new_monster_anims prefix, pattern, options
  end

  def new_wild_monster_anims(id, options={})
    monster_id = "wild_monster_#{id}"
    prefix = "#{monster_id}_"
    pattern = "wild_monster/#{id}/#{id}_${num}.bmp"
    new_monster_anims prefix, pattern, options
  end

  # ================== village monsters

  # ¹¥»÷·¶Î§¶¯»­Ð§¹û
  new_centered_anim :monster_attack_effect, 'monster/effect/Effect_${num}.bmp', [3, 17], 220

  new_village_monster_anims '0001', stand_down: [0, 11], move_down: [12, 19], attack_down: [20, 23],
                            stand_up: [24, 27], move_up: [28, 35], attack_up: [36, 39],
                            stand_hor: [40, 47], move_hor: [48, 51], attack_hor: [52, 55],
                            capitulate: [56, 61]

  new_village_monster_anims '0002', stand_down: [0, 3], move_down: [4, 7], attack_down: [9, 12],
                            stand_up: [13, 16], move_up: [17, 21], attack_up: [22, 25],
                            stand_hor: [26, 29], move_hor: [30, 34], attack_hor: [35, 38],
                            capitulate: [39, 40]

  attack_0004 = [9, 12]
  new_village_monster_anims '0004', stand_down: [0, 3], move_down: [4, 7], attack_down: attack_0004,
                            stand_up: [13, 16], move_up: [17, 20], attack_up: attack_0004,
                            stand_hor: [21, 24], move_hor: [25, 28], attack_hor: attack_0004,
                            capitulate: [29, 30]

  attack_0005 = [17, 23]
  new_village_monster_anims '0005', stand_down: [0, 7], move_down: [8, 15], attack_down: attack_0005,
                            stand_up: [24, 27], move_up: [28, 31], attack_up: attack_0005,
                            stand_hor: [32, 39], move_hor: [40, 47], attack_hor: attack_0005,
                            capitulate: [48, 54]

  attack_0006 = [8, 15]
  new_village_monster_anims '0006', stand_down: [0, 3], move_down: [4, 7], attack_down: attack_0006,
                            stand_up: [16, 19], move_up: [20, 23], attack_up: attack_0006,
                            stand_hor: [24, 27], move_hor: [28, 31], attack_hor: attack_0006,
                            capitulate: [32, 35]

  attack_0007 = [6, 9]
  new_village_monster_anims '0007', stand_down: [0, 3], move_down: [4, 5], attack_down: attack_0007,
                            stand_up: [10, 13], move_up: [14, 15], attack_up: attack_0007,
                            stand_hor: [16, 19], move_hor: [20, 21], attack_hor: attack_0007,
                            capitulate: [22, 25]

  attack_0008 = [8, 11]
  new_village_monster_anims '0008', stand_down: [0, 3], move_down: [4, 7], attack_down: attack_0008,
                            stand_up: [12, 15], move_up: [16, 19], attack_up: attack_0008,
                            stand_hor: [20, 23], move_hor: [24, 25], attack_hor: attack_0008,
                            capitulate: [26, 29]

  attack_20000 = [11, 15]
  new_village_monster_anims '20000', stand_down: [0, 4], move_down: [5, 10], attack_down: attack_20000,
                            stand_up: [16, 20], move_up: [21, 26], attack_up: [27, 31],
                            stand_hor: [32, 36], move_hor: [37, 42], attack_hor: attack_20000,
                            capitulate: [43, 47]

  # ================== wild monsters

  attack_0001_down_and_hor = [10, 18]
  new_wild_monster_anims '0001', stand_down: [0, 4], move_down: [5, 9], attack_down: attack_0001_down_and_hor,
                         stand_up: [19, 22], move_up: [23, 27], attack_up: [28, 35],
                         stand_hor: [36, 40], move_hor: [41, 45], attack_hor: attack_0001_down_and_hor,
                         capitulate: [46, 58]

  attack_0002_down_and_hor = [12, 20]
  new_wild_monster_anims '0002', stand_down: [0, 3], move_down: [4, 11], attack_down: attack_0002_down_and_hor,
                         stand_up: [21, 24], move_up: [25, 32], attack_up: [33, 39],
                         stand_hor: [40, 43], move_hor: [44, 48], attack_hor: attack_0002_down_and_hor,
                         capitulate: [49, 62]

  attack_0003_down_and_hor = [8, 13]
  new_wild_monster_anims '0003', stand_down: [0, 2], move_down: [3, 7], attack_down: attack_0003_down_and_hor,
                         stand_up: [14, 16], move_up: [17, 21], attack_up: [22, 27],
                         stand_hor: [28, 30], move_hor: [31, 35], attack_hor: attack_0003_down_and_hor,
                         capitulate: [36, 43]

  attack_0004 = [9, 11]
  new_wild_monster_anims '0004', stand_down: [0, 3], move_down: [4, 8], attack_down: attack_0004,
                         stand_up: [12, 15], move_up: [16, 19], attack_up: attack_0004,
                         stand_hor: [20, 23], move_hor: [24, 28], attack_hor: attack_0004,
                         capitulate: [29, 35]

  attack_0005 = [10, 16]
  new_wild_monster_anims '0005', stand_down: [0, 3], move_down: [4, 9], attack_down: attack_0005,
                         stand_up: [17, 20], move_up: [21, 26], attack_up: [27, 32],
                         stand_hor: [33, 36], move_hor: [37, 40], attack_hor: attack_0005,
                         capitulate: [41, 52]

  attack_0006_down_and_hor = [8, 19]
  new_wild_monster_anims '0006', stand_down: [0, 2], move_down: [3, 7], attack_down: attack_0006_down_and_hor,
                         stand_up: [20, 22], move_up: [23, 27], attack_up: [28, 39],
                         stand_hor: [40, 42], move_hor: [43, 47], attack_hor: attack_0006_down_and_hor,
                         capitulate: [48, 55]

  attack_0007_down_and_hor = [8, 16]
  new_wild_monster_anims '0007', stand_down: [0, 7], move_down: [0, 7], attack_down: attack_0007_down_and_hor,
                         stand_up: [17, 24], move_up: [17, 24], attack_up: [25, 33],
                         stand_hor: [34, 41], move_hor: [34, 41], attack_hor: attack_0007_down_and_hor,
                         capitulate: [42, 45]

  attack_0008_down_and_hor = [8, 14]
  new_wild_monster_anims '0008', stand_down: [0, 3], move_down: [4, 7], attack_down: attack_0008_down_and_hor,
                         stand_up: [15, 18], move_up: [19, 22], attack_up: [23, 29],
                         stand_hor: [30, 33], move_hor: [34, 37], attack_hor: attack_0008_down_and_hor,
                         capitulate: [38, 42]

  attack_0009_down_and_hor = [8, 13]
  new_wild_monster_anims '0009', stand_down: [0, 3], move_down: [4, 7], attack_down: attack_0009_down_and_hor,
                         stand_up: [14, 17], move_up: [18, 21], attack_up: [22, 27],
                         stand_hor: [28, 31], move_hor: [32, 35], attack_hor: attack_0009_down_and_hor,
                         capitulate: [36, 40]

  new_wild_monster_anims '0010', stand_down: [0, 3], move_down: [4, 7], attack_down: [8, 11],
                         stand_up: [12, 14], move_up: [15, 18], attack_up: [19, 22],
                         stand_hor: [23, 26], move_hor: [27, 30], attack_hor: [31, 34],
                         capitulate: [35, 41]

  attack_0011_down_and_hor = [8, 12]
  new_wild_monster_anims '0011', stand_down: [0, 4], move_down: [5, 7], attack_down: attack_0011_down_and_hor,
                         stand_up: [13, 17], move_up: [18, 21], attack_up: [22, 25],
                         stand_hor: [26, 30], move_hor: [31, 33], attack_hor: attack_0011_down_and_hor,
                         capitulate: [34, 36]

  # ÷¼÷ÃÍ·
  attack_0012_down_and_hor = [10, 14]
  new_wild_monster_anims '0012', stand_down: [0, 4], move_down: [5, 9], attack_down: attack_0012_down_and_hor,
                         stand_up: [15, 19], move_up: [20, 24], attack_up: [25, 29],
                         stand_hor: [30, 34], move_hor: [35, 39], attack_hor: attack_0012_down_and_hor,
                         capitulate: [40, 47]

  attack_0013_down_and_hor = [11, 15]
  new_wild_monster_anims '0013', stand_down: [0, 4], move_down: [5, 10], attack_down: attack_0013_down_and_hor,
                         stand_up: [16, 20], move_up: [21, 26], attack_up: [27, 31],
                         stand_hor: [32, 36], move_hor: [37, 42], attack_hor: attack_0013_down_and_hor,
                         capitulate: [43, 47]

  attack_0014_down_and_hor = [11, 13]
  new_wild_monster_anims '0014', stand_down: [0, 4], move_down: [5, 10], attack_down: attack_0014_down_and_hor,
                         stand_up: [14, 18], move_up: [19, 24], attack_up: [25, 27],
                         stand_hor: [28, 32], move_hor: [33, 38], attack_hor: attack_0014_down_and_hor,
                         capitulate: [39, 41]

  new_wild_monster_anims '0015', stand_down: [0, 7], move_down: [8, 15], attack_down: [16, 23],
                         stand_up: [24, 31], move_up: [32, 39], attack_up: [40, 47],
                         stand_hor: [48, 55], move_hor: [56, 63], attack_hor: [64, 71],
                         capitulate: [72, 77]

}.call