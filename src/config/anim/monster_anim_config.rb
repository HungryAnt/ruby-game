lambda {
  def new_monster_anims(id, options={})
    monster_id = "monster_#{id}"
    prefix = "#{monster_id}_"
    pattern = "monster/#{id}/#{id}_${num}.bmp"

    new_direction_anims prefix, pattern, 'stand',
                        hor_nums_pair:options[:stand_hor],
                        up_nums_pair:options[:stand_up],
                        down_nums_pair:options[:stand_down],
                        anim_interval:250

    new_direction_anims prefix, pattern, 'move',
                        hor_nums_pair:options[:move_hor],
                        up_nums_pair:options[:move_up],
                        down_nums_pair:options[:move_down],
                        need_down_right_anim:true

    new_direction_anims prefix, pattern, 'attack',
                        hor_nums_pair:options[:attack_hor],
                        up_nums_pair:options[:attack_up],
                        down_nums_pair:options[:attack_down],
                        anim_interval:250,
                        reversed:false

    new_direction_anims prefix, pattern, 'capitulate',
                        hor_nums_pair:options[:capitulate],
                        up_nums_pair:options[:capitulate],
                        down_nums_pair:options[:capitulate],
                        anim_interval:250,
                        reversed:false
  end

  # ¹¥»÷·¶Î§¶¯»­Ð§¹û
  new_centered_anim :monster_attack_effect, 'monster/effect/Effect_${num}.bmp', [3, 17], 220

  new_monster_anims '0001', stand_down:[0, 11], move_down:[12, 19], attack_down:[20, 23],
                    stand_up:[24, 27], move_up:[28, 35], attack_up:[36, 39],
                    stand_hor:[40, 47], move_hor:[48, 51], attack_hor:[52, 55],
                    capitulate:[56, 61]

  new_monster_anims '0002', stand_down:[0, 3], move_down:[4, 7], attack_down:[9, 12],
                    stand_up:[13, 16], move_up:[17, 21], attack_up:[22, 25],
                    stand_hor:[26, 29], move_hor:[30, 34], attack_hor:[35, 38],
                    capitulate:[39, 40]

  attack_0004 = [9, 12]
  new_monster_anims '0004', stand_down:[0, 3], move_down:[4, 7], attack_down:attack_0004,
                    stand_up:[13, 16], move_up:[17, 20], attack_up:attack_0004,
                    stand_hor:[21, 24], move_hor:[25, 28], attack_hor:attack_0004,
                    capitulate:[29, 30]

  attack_0005 = [17, 23]
  new_monster_anims '0005', stand_down:[0, 7], move_down:[8, 15], attack_down:attack_0005,
                    stand_up:[24, 27], move_up:[28, 31], attack_up:attack_0005,
                    stand_hor:[32, 39], move_hor:[40, 47], attack_hor:attack_0005,
                    capitulate:[48, 54]

  attack_0006 = [8, 15]
  new_monster_anims '0006', stand_down:[0, 3], move_down:[4, 7], attack_down:attack_0006,
                    stand_up:[16, 19], move_up:[20, 23], attack_up:attack_0006,
                    stand_hor:[24, 27], move_hor:[28, 31], attack_hor:attack_0006,
                    capitulate:[32, 35]

  attack_0007 = [6, 9]
  new_monster_anims '0007', stand_down:[0, 3], move_down:[4, 5], attack_down:attack_0007,
                    stand_up:[10, 13], move_up:[14, 15], attack_up:attack_0007,
                    stand_hor:[16, 19], move_hor:[20, 21], attack_hor:attack_0007,
                    capitulate:[22, 25]

  attack_0008 = [8, 11]
  new_monster_anims '0008', stand_down:[0, 3], move_down:[4, 7], attack_down:attack_0008,
                    stand_up:[12, 15], move_up:[16, 19], attack_up:attack_0008,
                    stand_hor:[20, 23], move_hor:[24, 25], attack_hor:attack_0008,
                    capitulate:[26, 29]

  attack_20000 = [11, 15]
  new_monster_anims '20000', stand_down:[0, 4], move_down:[5, 10], attack_down:attack_20000,
                    stand_up:[16, 20], move_up:[21, 26], attack_up:[27, 31],
                    stand_hor:[32, 36], move_hor:[37, 42], attack_hor:attack_20000,
                    capitulate:[43, 47]
}.call