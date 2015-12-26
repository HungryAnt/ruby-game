class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # ͷ��
    EYE_WEAR = :eye_wear # �۲���Ʒ
    AREA_ADDITION = :area_addition # ��������
    WING = :wing # ���
    HAT = :hat # ñ��
  end

  attr_reader :key, :type

  def initialize(type, key)
    @type = type
    @key = key
  end
end