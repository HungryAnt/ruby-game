class EquipmentDefinition
  @@location_offset_map = {}
  @@item_image_map = {}

  def self.set_location_offset(key, offset)
    @@location_offset_map[key] = offset
  end

  def self.get_location_offset(key)
    return @@location_offset_map[key]
  end

  def self.set_item_image(key, img_path)
    @@item_image_map[key] = MediaUtil.get_img(img_path)
  end

  def self.get_item_image(key)
    @@item_image_map[key]
  end
end