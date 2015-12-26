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

  def self.get_item_animation(goods_category, key)
    case goods_category
      when :vehicles, :nostalgicVehicles
        anim_key = "#{key}_down"
      when :pets
        anim_key = "#{key}_stand_down"
      else
        raise ArgumentError 'unexpected goods_category:' + goods_category
    end
    AnimationManager.get_anim anim_key.to_sym
  end
end