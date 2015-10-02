# coding: UTF-8

class PlayerService
  attr_reader :role, :user_id

  def initialize
    autowired(UserService, CommunicationService)
    @user_id = ''
  end

  def init
    @user_id = @user_service.user_id
    user_name = @user_service.user_name
    role_type = @user_service.role_type
    puts "player name: #{user_name}"
    @role = Role.new(user_name, role_type, 100, 300)
    @communication_service.init_sync_user @user_id, user_name
  end

  def update_sync_data
    @role.update_lv @user_service.lv, @user_service.exp

    # if GameConfig::DEBUG
    #   [39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 90, 91, 604, 828,
    #    96, 97, 103, 104, 108, 109, 114, 115, 119, 121
    #   ].each do |num|
    #     vehicle_key = "vehicle_#{num}".to_sym
    #     @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
    #   end
    # else
      vehicles = @user_service.vehicles
      update_vehicles vehicles
    # end

    @role.rubbish_bin.update(@user_service.rubbishes)
  end

  def update_vehicles(vehicles)
    @role.package.clear
    vehicles.each do |vehicle|
      @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle.to_sym)
    end
  end

  def clear_rubbishes
    @role.rubbish_bin.clear
  end
end