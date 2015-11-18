lambda {


  def new_pet_anims(id, options={})
    pet_num = id
    pet_type_prefix = "pet_#{pet_num}_"
    pet_pattern = "pet/#{pet_num}/#{pet_num}_${num}.bmp"

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

  new_pet_anims 1, stand_hor:[60, 63], stand_up:[40, 43], stand_down:[0, 3],
                move_hor:[64, 67], move_up:[44, 47], move_down:[4, 7],
                attack_hor:[68, 79], attack_up:[48, 59], attack_down:[8, 19],
                sleep:[20, 23], cute:[24, 39]

  new_pet_anims 2, stand_hor:[56, 59], stand_up:[39, 42], stand_down:[0, 3],
                move_hor:[60, 63], move_up:[43, 46], move_down:[4, 7],
                attack_hor:[64, 72], attack_up:[47, 55], attack_down:[8, 16],
                sleep:[17, 20], cute:[21, 38]
}.call