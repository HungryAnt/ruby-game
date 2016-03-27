module VehicleSpeed
  attr_accessor :vehicle_speed_up

  def set_vehicle_speed(speed_up)
    @vehicle_speed = speed_up
  end

  private
  def init_vehicle_speed
    @vehicle_speed = 0
  end

  def update_speed(vehicle_equipments)
    if vehicle_equipments.nil? || vehicle_equipments.size == 0
      @vehicle_speed = 0
      return
    end
    (vehicle_equipments.size >= 5) ? @vehicle_speed = 0.92 : @vehicle_speed = 0
    vehicle_equipments.each do |equipment|
      next if equipment.is_dragon?
      if equipment.speed_up > @vehicle_speed
        @vehicle_speed = equipment.speed_up
      end
    end
  end
end