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
    update_pets unless GameConfig::DEBUG
  end

  def update_sync_data
    @role.update_lv @user_service.lv, @user_service.exp

    if GameConfig::DEBUG
      #[39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 90, 91, 604, 828,
      # 96, 97, 103, 104, 108, 109, 114, 115, 119, 121
      [#138, 228, 301, 402, 450, 552, 558, 569, 144, 163, 220,
          321, 322, 326, 327, 331, 332, 336, 340, 345, 346, 354, 359,
          168, 172, 178, 188, 222, 433, 497, 574, 598, 708, 723, 697, 710, 711, 802, 402, 521, 662, 376, 456, 381, 439
      ].each do |num|
        vehicle_key = "vehicle_#{num}".to_sym
        @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
      end
      # [10, 24, 26, 35, 39, 41, 43, 69, 119
      # ].each do |num|
      #   vehicle_key = "vehicle2_#{num}".to_sym
      #   @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
      # end
      %w(DragonRed DragonBlack DragonBlue).each do |dragon|
        dragon_key = "dragon_#{dragon}".to_sym
        @role.package << Equipment.new(Equipment::Type::VEHICLE, dragon_key)
      end

      PetTypeInfo.all_pet_types.each do |pet_type|
        @role.pet_package << Pet.new(SecureRandom.uuid, pet_type, 200, 200)
      end

      [17, 20, 21, 97, 282].each do |num|
        key = "eye_wear_#{num}".to_sym
        @role.eye_wear_package << Equipment.new(Equipment::Type::EYE_WEAR, key)
      end

      [16, 48, 51, 52, 94, 130, 131, 253, 278, 316, 338, 355,
       394, 430, 467, 486, 559, 587, 617, 686, 715, 772, 795, 819].each do |num|
        key = "wing_#{num}".to_sym
        @role.wing_package << Equipment.new(Equipment::Type::WING, key)
      end

      [2, 18, 20, 21, 22, 24, 37, 38, 392, 395].each do |num|
        key = "hat_#{num}".to_sym
        @role.hat_package << Equipment.new(Equipment::Type::HAT, key)
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

  def update_pets
    pets = YecaiWebClient.get_pets_by_user_id(@user_id)
    return if pets.length == 0
    @role.pet_package.clear
    pets.each { |pet| @role.pet_package << pet }
  end
end