class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # ͷ��
    EYE_WEAR = :eye_wear # �۲���Ʒ
    AREA_ADDITION = :area_addition # ��������
    WING = :wing # ���
    HAT = :hat # ñ��
    UNDERPAN = :underpan # ����
  end

  attr_reader :key, :type, :location_offset, :miss, :speed_up

  def initialize(type, key)
    @type = type
    @key = key

    props = EquipmentDefinition.get_props @key
    @location_offset = props[:offset]
    @miss = props[:miss] # ����
    @speed_up = props[:speed_up] # ����
  end
end