lambda {
  pattern_pet_union = 'pet_union_room/PetUinonRoom_${num}.bmp'

  new_map_covering_anim(:pet_union_button_press, pattern_pet_union, 3, 10, 200, false)
  new_map_covering_anim(:pet_union_spirit_0, pattern_pet_union, 11, 14, 200, false)
  new_map_covering_anim(:pet_union_spirit_1, pattern_pet_union, 15, 18, 200, false)
  new_map_covering_anim(:pet_union_spirit_2, pattern_pet_union, 19, 22, 200, false)


  new_map_covering_anim(:pet_union_big_frog_open_mouth, pattern_pet_union, 23, 25, 200, false)
  new_map_covering_anim(:pet_union_big_frog, pattern_pet_union, 28, 49, 200, false)

  new_map_covering_anim(:pet_union_button_line, pattern_pet_union, 50, 54, 200, false)

  new_map_covering_anim(:pet_union_spirit_3, pattern_pet_union, 55, 76, 200, false)
}.call