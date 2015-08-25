class Equipment
  module Type
    VEHICLE = :vehicle
    WEAPON = :weapon
  end

  attr_reader :key

  def initialize(type, key)
    @type = type
    @key = key
  end
end