lambda {


  def new_pet_anims(flag, num, options={})
    pet_id = "#{flag}#{num}"
    pet_type_prefix = "pet_#{pet_id}_"
    pet_pattern = "pet/#{pet_id}/#{num}_${num}.bmp"

    new_direction_anims pet_type_prefix, pet_pattern, 'stand',
                        hor_nums_pair:options[:stand_hor],
                        up_nums_pair:options[:stand_up],
                        down_nums_pair:options[:stand_down],
                        anim_interval:250

    new_direction_anims pet_type_prefix, pet_pattern, 'move',
                        hor_nums_pair:options[:move_hor],
                        up_nums_pair:options[:move_up],
                        down_nums_pair:options[:move_down],
                        need_down_right_anim:true

    new_direction_anims pet_type_prefix, pet_pattern, 'attack',
                        hor_nums_pair:options[:attack_hor],
                        up_nums_pair:options[:attack_up],
                        down_nums_pair:options[:attack_down],
                        reversed:false

    new_direction_anims_with_same_imgs pet_type_prefix, pet_pattern, 'sleep', options[:sleep], anim_interval:400

    new_direction_anims_with_same_imgs pet_type_prefix, pet_pattern, 'cute', options[:cute], anim_interval:200
  end

  new_pet_anims 'c', 1, stand_hor:[60, 63], stand_up:[40, 43], stand_down:[0, 3],
                move_hor:[64, 67], move_up:[44, 47], move_down:[4, 7],
                attack_hor:[68, 79], attack_up:[48, 59], attack_down:[8, 19],
                sleep:[20, 23], cute:[24, 39]

  new_pet_anims 'c', 2, stand_hor:[56, 59], stand_up:[39, 42], stand_down:[0, 3],
                move_hor:[60, 63], move_up:[43, 46], move_down:[4, 7],
                attack_hor:[64, 72], attack_up:[47, 55], attack_down:[8, 16],
                sleep:[17, 20], cute:[21, 38]

  new_pet_anims 'c', 3, stand_hor:[51, 54], stand_up:[35, 38], stand_down:[0, 3],
                move_hor:[55, 58], move_up:[39, 42], move_down:[4, 7],
                attack_hor:[59, 66], attack_up:[43, 50], attack_down:[8, 15],
                sleep:[67, 74], cute:[16, 34]

  new_pet_anims 'f', 1, stand_hor:[48, 51], stand_up:[28, 31], stand_down:[0, 3],
                move_hor:[52, 55], move_up:[32, 35], move_down:[4, 7],
                attack_hor:[56, 67], attack_up:[36, 47], attack_down:[8, 19],
                sleep:[20, 23], cute:[24, 27]

  new_pet_anims 'f', 2, stand_hor:[60, 63], stand_up:[39, 42], stand_down:[0, 3],
                move_hor:[64, 67], move_up:[43, 46], move_down:[4, 7],
                attack_hor:[68, 80], attack_up:[47, 59], attack_down:[8, 20],
                sleep:[21, 24], cute:[25, 38]

  new_pet_anims 'f', 3, stand_hor:[60, 63], stand_up:[45, 48], stand_down:[0, 3],
                move_hor:[64, 67], move_up:[49, 52], move_down:[4, 7],
                attack_hor:[68, 81], attack_up:[53, 59], attack_down:[8, 22],
                sleep:[23, 27], cute:[28, 44]

  new_pet_anims 'c', 37, stand_hor:[96, 107], stand_up:[60, 71], stand_down:[0, 11],
                move_hor:[108, 113], move_up:[72, 77], move_down:[12, 17],
                attack_hor:[114, 131], attack_up:[78, 95], attack_down:[18, 35],
                sleep:[36, 47], cute:[48, 59]

  new_pet_anims 'g', 1, stand_down:[0, 3], move_down:[4, 7], attack_down:[8, 28],
                sleep:[29, 32], cute:[33, 36], stand_up:[37, 40], move_up:[41, 44],
                attack_up:[45, 65], stand_hor:[66, 69], move_hor:[70, 73], attack_hor:[74, 94]

  new_pet_anims 'g', 2, stand_down:[0, 3], move_down:[4, 7], attack_down:[8, 24],
                sleep:[25, 28], cute:[29, 36], stand_up:[37, 40], move_up:[41, 44],
                attack_up:[45, 62], stand_hor:[63, 66], move_hor:[67, 70], attack_hor:[71, 88]

  new_pet_anims 'g', 3, stand_down:[0, 3], move_down:[4, 9], attack_down:[10, 19],
                sleep:[20, 23], cute:[24, 29], stand_up:[41, 44], move_up:[45, 48],
                attack_up:[49, 58], stand_hor:[59, 62], move_hor:[63, 70], attack_hor:[71, 80]

  new_pet_anims 'g', 4, stand_down:[0, 3], move_down:[4, 7], attack_down:[8, 18],
                sleep:[19, 22], cute:[23, 26], stand_up:[27, 30], move_up:[31, 34],
                attack_up:[35, 45], stand_hor:[46, 49], move_hor:[50, 53], attack_hor:[54, 64]

  new_pet_anims 'g', 5, stand_down:[0, 6], move_down:[7, 14], attack_down:[15, 35],
                sleep:[36, 47], cute:[48, 61], stand_up:[66, 77], move_up:[78, 86],
                attack_up:[87, 106], stand_hor:[107, 120], move_hor:[121, 127], attack_hor:[128, 148]

  new_pet_anims 'g', 6, stand_down:[0, 3], move_down:[4, 7], attack_down:[8, 16],
                sleep:[17, 20], cute:[21, 24], stand_up:[25, 28], move_up:[29, 32],
                attack_up:[33, 41], stand_hor:[42, 45], move_hor:[46, 49], attack_hor:[50, 58]

  new_pet_anims 'g', 7, stand_down:[0, 3], move_down:[4, 7], attack_down:[8, 19],
                sleep:[20, 23], cute:[24, 37], stand_up:[38, 41], move_up:[42, 45],
                attack_up:[46, 57], stand_hor:[58, 61], move_hor:[62, 65], attack_hor:[66, 77]

  new_pet_anims 'g', 8, stand_down:[0, 3], move_down:[4, 9], attack_down:[10, 13],
                sleep:[14, 21], cute:[22, 23], stand_up:[26, 28], move_up:[29, 31],
                attack_up:[32, 35], stand_hor:[36, 39], move_hor:[40, 45], attack_hor:[46, 49]
}.call