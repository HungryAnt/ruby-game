# coding: UTF-8

require 'securerandom'

class PlayerService
  attr_reader :role, :user_id, :wears

  def initialize
    autowired(UserService, CommunicationService)
    @user_id = ''
    @wears = {}
  end

  def init
    @user_id = @user_service.user_id
    user_name = @user_service.user_name
    role_type = @user_service.role_type
    puts "player name: #{user_name}"
    @role = Role.new(user_name, role_type, 100, 300)
    @communication_service.init_sync_user @user_id, user_name
    update_pets unless GameConfig::DEBUG
    update_equipments unless GameConfig::DEBUG
  end

  def update_sync_data
    @role.update_lv @user_service.lv, @user_service.exp

    if GameConfig::DEBUG
      init_test_equipments
    else
      vehicles = @user_service.vehicles
      update_vehicles vehicles
      @wears = @user_service.wears
    end

    @role.rubbish_bin.update(@user_service.rubbishes)
    @role.nutrient_bin.update(@user_service.nutrients)
  end

  def init_test_equipments
    @role.package.clear
    #[39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 90, 91, 604, 828,
    # 96, 97, 103, 104, 108, 109, 114, 115, 119, 121
    [
        #138, 228, 301, 402, 450, 552, 558, 569, 144, 163, 220,
        # 321, 322, 326, 327, 331, 332, 336, 340, 345, 346, 354, 359,
        # 168, 172, 178, 188, 222, 433, 497, 514, 574, 598, 708, 723,
        # 697, 710, 711, 802, 402, 521, 662, 376, 456, 381, 439,
        # 450, 192, 461
        125, 126, 127, 132, 133, 139, 143, 148, 149, 153, 154, 159, 160
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

    @role.pet_package.clear
    PetTypeInfo.all_pet_types.each do |pet_type|
      @role.pet_package << Pet.new(SecureRandom.uuid, pet_type, 200, 200)
    end

    @role.eye_wear_package.clear
    [1, 17, 20, 21, 97, 282].each do |num|
      key = "eye_wear_#{num}".to_sym
      @role.eye_wear_package << Equipment.new(Equipment::Type::EYE_WEAR, key)
    end

    [1, 8, 9, 29, 32, 53, 62, 69, 226, 261, 281, 357, 375
    ].each do |num|
      key = "eye_wear2_#{num}".to_sym
      @role.eye_wear_package << Equipment.new(Equipment::Type::EYE_WEAR, key)
    end

    @role.wing_package.clear
    [16, 48, 51, 52, 94, 130, 131, 253, 278, 316, 338, 355,
     394, 430, 467, 486, 559, 587, 617, 686, 715, 772, 795, 819].each do |num|
      key = "wing_#{num}".to_sym
      @role.wing_package << Equipment.new(Equipment::Type::WING, key)
    end

    [13, 15, 16].each do |num|
      key = "wing2_#{num}".to_sym
      @role.wing_package << Equipment.new(Equipment::Type::WING, key)
    end

    @role.hat_package.clear
    [
        # 2, 18, 20, 21, 22, 24, 37, 38, 392, 395,
        # 5, 10, 12, 14, 25, 26, 27, 34, 35, 36, 41, 43, 45, 46, 47, 49, 56, 61,
        # 66, 68, 72, 73, 80, 85, 86, 88, 93, 95, 100, 101,
        105, 107, 111, 113, 118, 120, 122, 123, 124, 129, 135, 136, 141, 142,
        145, 147, 150, 152, 156, 157,
        158, 162, 166, 170, 171,
        423
    ].each do |num|
      key = "hat_#{num}".to_sym
      @role.hat_package << Equipment.new(Equipment::Type::HAT, key)
    end

    # [12, 23, 25, 42, 47, 49].each do |num|
    #   key = "hat2_#{num}".to_sym
    #   @role.hat_package << Equipment.new(Equipment::Type::HAT, key)
    # end

    @role.underpan_package.clear
    [13, 17, 102, 234, 349, 418, 443, 454, 471].each do |num|
      key = "underpan_#{num}".to_sym
      @role.underpan_package << Equipment.new(Equipment::Type::UNDERPAN, key)
    end

    @role.handheld_package.clear
    [3, 23, 42, 44, 54, 60, 65, 71, 76, 77, 87, 106, 684, 689].each do |num|
      key = "handheld_#{num}".to_sym
      @role.handheld_package << Equipment.new(Equipment::Type::HANDHELD, key)
    end

    @role.ear_wear_package.clear
    [266, 292, 342, 352, 361, 379, 384, 403, 414, 427, 463,].each do |num|
      key = "ear_wear_#{num}".to_sym
      @role.ear_wear_package << Equipment.new(Equipment::Type::EAR_WEAR, key)
    end
  end

  def refresh_all_equipments
    @role.equipment_packages.each do |package|
      package.items.each do |equipment|
        equipment.refresh
      end
    end
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

  def update_equipments
    @role.wing_package.clear
    @role.hat_package.clear
    @role.eye_wear_package.clear

    equipments = YecaiWebClient.get_equipments_by_user_id(@user_id)
    return if equipments.nil? || equipments.length == 0
    equipments.each do |equipment|
      case equipment.type
        when Equipment::Type::WING
          @role.wing_package << equipment
        when Equipment::Type::HAT
          @role.hat_package << equipment
        when Equipment::Type::EYE_WEAR
          @role.eye_wear_package << equipment
        when Equipment::Type::EAR_WEAR
          @role.ear_wear_package << equipment
      end
    end
  end
end