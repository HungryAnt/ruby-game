class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
    HELMET = :helmet # Í·¿ø
    EYE_WEAR = :eye_wear # ÑÛ²¿ÊÎÆ·
  end

  attr_reader :key, :type

  def initialize(type, key)
    @type = type
    @key = key
  end
end