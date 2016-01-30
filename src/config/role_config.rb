lambda {
  set_role_photo = lambda do |role_type, unselected_num, seleceted_num, chess_piece_num|
    unselected_image = MediaUtil.get_img "role/koongya/Koongya_#{unselected_num}.bmp"
    selected_image = MediaUtil.get_img "role/koongya/Koongya_#{seleceted_num}.bmp"
    chess_piece_image = MediaUtil.get_img "map/chess/items/Al_#{chess_piece_num}.bmp"
    RoleTypeDefinition.set_role_photo(role_type, unselected_image, selected_image, chess_piece_image)
  end

  set_role_photo.call(RoleType::YANGPA, 0, 1, 2)
  set_role_photo.call(RoleType::WAN_GYE, 2, 3, 5)
  set_role_photo.call(RoleType::MOO, 4, 5, 8)
  set_role_photo.call(RoleType::KIMCHI, 6, 7, 11)
  set_role_photo.call(RoleType::RICE, 8, 9, 14)
  set_role_photo.call(RoleType::PIMENTO, 10, 11, 17)
  set_role_photo.call(RoleType::YANGBEA, 12, 13, 20)
  set_role_photo.call(RoleType::BANGYE, 14, 15, 23)
  set_role_photo.call(RoleType::DOOBU, 16, 17, 26)
  set_role_photo.call(RoleType::SALARY, 18, 19, 29)
  set_role_photo.call(RoleType::MANL, 20, 21, 32)
  set_role_photo.call(RoleType::PASERY, 22, 23, 35)
}.call


