class RoleTypeDefinition
  @@role_photo_map = {}

  def self.set_role_photo(role_type, unselected_image, selected_image, chess_piece_iamge)
    @@role_photo_map[role_type] = [unselected_image, selected_image, chess_piece_iamge]
  end

  def self.get_role_unselected_photo(role_type)
    @@role_photo_map[role_type][0]
  end

  def self.get_role_selected_photo(role_type)
    @@role_photo_map[role_type][1]
  end

  def self.get_role_chess_piece_image_path(role_type)
    @@role_photo_map[role_type][2]
  end
end