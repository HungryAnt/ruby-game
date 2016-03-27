class Equipment
  module Type
    BACKGROUND = :background # ����
    VEHICLE = :vehicle
    EYE_WEAR = :eye_wear # �۲���Ʒ
    AREA_ADDITION = :area_addition # ��������
    WING = :wing # ���
    HAT = :hat # ñ��
    UNDERPAN = :underpan # ����
    HANDHELD = :handheld
    EAR_WEAR = :ear_wear # ������Ʒ
    FOREGROUND = :foreground # ǰ��װ��
  end

  def self.role_equipment_types
    [Type::BACKGROUND, Type::VEHICLE, Type::EYE_WEAR, Type::WING, Type::HAT,
     Type::UNDERPAN, Type::HANDHELD, Type::EAR_WEAR, Type::FOREGROUND]
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

  def is_dragon?
    @key.to_s.start_with?('dragon')
  end
end