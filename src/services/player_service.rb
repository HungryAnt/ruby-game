# coding: UTF-8

require 'securerandom'

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

    if GameConfig::DEBUG
      # [39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 90, 91, 604, 828,
      #  96, 97, 103, 104, 108, 109, 114, 115, 119, 121
      # ].each do |num|
      #   vehicle_key = "vehicle_#{num}".to_sym
      #   @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
      # end
      [10, 24, 26, 35, 39, 41, 43, 69, 119
      ].each do |num|
        vehicle_key = "vehicle2_#{num}".to_sym
        @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
      end
      %w(DragonRed DragonBlack DragonBlue).each do |dragon|
        dragon_key = "dragon_#{dragon}".to_sym
        @role.package << Equipment.new(Equipment::Type::VEHICLE, dragon_key)
      end

      PetTypeInfo.all_pet_types.each do |pet_type|
        @role.package << Pet.new(SecureRandom.uuid, pet_type, 200, 200)
      end
    else
      vehicles = @user_service.vehicles
      update_vehicles vehicles
    end

    @role.rubbish_bin.update(@user_service.rubbishes)
    @role.nutrient_bin.update(@user_service.nutrients)
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