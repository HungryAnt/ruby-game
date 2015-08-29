class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # ͷ��
  end

  attr_reader :key, :type

  def initialize(type, key)
    @type = type
    @key = key
  end
end