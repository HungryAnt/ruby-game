lambda {


  def new_pet_anims(flag, num, options={})
    pet_id = "#{flag}#{num}"
    pet_type_prefix = "pet_#{pet_id}_"
    pet_pattern = "pet/#{pet_id}/#{num}_${num}.bmp"

    new_direction_anims pet_type_prefix, pet_pattern, 'stand',
                        hor_nums_pair:options[:stand_hor],
                        up_nums_pair:options[:stand_up],
                        down_nums_pair:options[:stand_down]

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
}.call