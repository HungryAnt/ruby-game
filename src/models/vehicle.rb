class Vehicle
  attr_reader :key, :speed_up

  def initialize(key, speed_up)
    @key, @speed_up = key, speed_up
  end
end