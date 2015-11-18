lambda {
  pet_num = 1
  pet_type_prefix = "pet_#{pet_num}_"
  pet_pattern = "pet/#{pet_num}/#{pet_num}_${num}.bmp"
  new_direction_anims pet_type_prefix, pet_pattern, 'stand',
                      hor_nums_pair:[60, 63], up_nums_pair:[40, 43], down_nums_pair:[0, 3]

  new_direction_anims pet_type_prefix, pet_pattern, 'move',
                      hor_nums_pair:[64, 67], up_nums_pair:[44, 47], down_nums_pair:[4, 7],
                      need_down_right_anim:true

  new_direction_anims pet_type_prefix, pet_pattern, 'attack',
                      hor_nums_pair:[68, 79], up_nums_pair:[48, 59], down_nums_pair:[8, 19],
                      reversed:false

  new_direction_anims_with_same_imgs pet_type_prefix, pet_pattern, 'sleep', [20, 23], anim_interval:400

  new_direction_anims_with_same_imgs pet_type_prefix, pet_pattern, 'cute', [24, 39], anim_interval:200
}.call