class Equipment
  module Type
    VEHICLE = :vehicle
    EYE_WEAR = :eye_wear # 眼部饰品
    AREA_ADDITION = :area_addition # 场景附加
    WING = :wing # 翅膀
    HAT = :hat # 帽子
    UNDERPAN = :underpan # 底盘
    HANDHELD = :handheld
    EAR_WEAR = :ear_wear # 耳部饰品
  end

  def self.role_equipment_types
    [Type::VEHICLE, Type::EYE_WEAR, Type::WING, Type::HAT, Type::UNDERPAN, Type::HANDHELD, Type::EAR_WEAR]
  end

  attr_reader :key, :type, :location_offset, :miss, :speed_up, :height, :is_cloak

  def initialize(type, key)
    @type = type
    @key = key
    refresh
  end

  def refresh
    props = EquipmentDefinition.get_props @key
    @location_offset = props[:offset]
    @miss = props[:miss] # 闪避
    @speed_up = props[:speed_up] # 加速
    @height = props[:height] # 高度
    @is_cloak = props[:is_cloak] # 是否是披风
  end
end