class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # ͷ��
    EYE_WEAR = :eye_wear # �۲���Ʒ
  end

  attr_reader :key, :type

  def initialize(type, key)
    @type = type
    @key = key
  end
end