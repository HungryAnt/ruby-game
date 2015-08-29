class EquipmentDefinition
  @@location_offset_map = {}
  @@body_height_map = {}
  @@item_image_map = {}

  def self.set_location_offset(key, offset)
    @@location_offset_map[key] = offset
  end

  def self.get_location_offset(key)
    @@location_offset_map[key]
  end

  def self.set_body_height(key, body_height)
    @@body_height_map[key] = body_height
  end

  def self.get_body_height(key)
    @@body_height_map[key]
  end

  def self.set_item_image(key, img_path)
    @@item_image_map[key] = MediaUtil.get_img(img_path)
  end

  def self.get_item_image(key)
    @@item_image_map[key]
  end
end