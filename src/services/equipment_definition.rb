class EquipmentDefinition
  @@item_image_map = {}
  @@props_map = {}

  def self.set_item_image(key, img_path)
    @@item_image_map[key] = MediaUtil.get_img(img_path)
  end

  def self.get_item_image(key)
    @@item_image_map[key]
  end

  def self.set_props(key, props)
    @@props_map[key] = props
  end

  def self.get_props(key)
    @@props_map[key]
  end
end