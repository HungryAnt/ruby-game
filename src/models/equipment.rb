class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # 头盔
    EYE_WEAR = :eye_wear # 眼部饰品
    AREA_ADDITION = :area_addition # 场景附加
    WING = :wing # 翅膀
    HAT = :hat # 帽子
    UNDERPAN = :underpan # 底盘
  end

  attr_reader :key, :type, :location_offset, :miss, :speed_up

  def initialize(type, key)
    @type = type
    @key = key

    props = EquipmentDefinition.get_props @key
    @location_offset = props[:offset]
    @miss = props[:miss] # 闪避
    @speed_up = props[:speed_up] # 加速
  end
end