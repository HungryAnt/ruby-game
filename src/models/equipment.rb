class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # 头盔
    EYE_WEAR = :eye_wear # 眼部饰品
    AREA_ADDITION = :area_addition # 场景附加
    WING = :wing # 翅膀
    HAT = :hat # 帽子
  end

  attr_reader :key, :type

  def initialize(type, key)
    @type = type
    @key = key
  end
end