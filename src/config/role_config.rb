def set_role_photo(role_type, unselected_num, seleceted_num)
  unselected_image = MediaUtil.get_img "role/koongya/Koongya_#{unselected_num}.bmp"
  selected_image = MediaUtil.get_img "role/koongya/Koongya_#{seleceted_num}.bmp"
  RoleTypeDefinition.set_role_photo(role_type, unselected_image, selected_image)
end

set_role_photo(RoleType::YANGPA, 0, 1)
set_role_photo(RoleType::WAN_GYE, 2, 3)
set_role_photo(RoleType::MOO, 4, 5)
set_role_photo(RoleType::KIMCHI, 6, 7)
set_role_photo(RoleType::RICE, 8, 9)
set_role_photo(RoleType::PIMENTO, 10, 11)
set_role_photo(RoleType::YANGBEA, 12, 13)
set_role_photo(RoleType::BANGYE, 14, 15)
set_role_photo(RoleType::DOOBU, 16, 17)
set_role_photo(RoleType::SALARY, 18, 19)
set_role_photo(RoleType::MANL, 20, 21)
set_role_photo(RoleType::PASERY, 22, 23)
