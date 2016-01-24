class Equipment
  module Type
    VEHICLE = :vehicle
    EYE_WEAR = :eye_wear # �۲���Ʒ
    AREA_ADDITION = :area_addition # ��������
    WING = :wing # ���
    HAT = :hat # ñ��
    UNDERPAN = :underpan # ����
    HANDHELD = :handheld
    EAR_WEAR = :ear_wear # ������Ʒ
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
    @miss = props[:miss] # ����
    @speed_up = props[:speed_up] # ����
    @height = props[:height] # �߶�
    @is_cloak = props[:is_cloak] # �Ƿ�������
  end
end