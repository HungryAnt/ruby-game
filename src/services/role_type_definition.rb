class RoleTypeDefinition
  @@role_photo_map = {}

  def self.set_role_photo(role_type, unselected_image, selected_image)
    @@role_photo_map[role_type] = [unselected_image, selected_image]
  end

  def self.get_role_unselected_photo(role_type)
    @@role_photo_map[role_type][0]
  end

  def self.get_role_selected_photo(role_type)
    @@role_photo_map[role_type][1]
  end
end