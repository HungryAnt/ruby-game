# coding: UTF-8

require 'securerandom'

class PlayerService
  attr_reader :role, :user_id, :wears
  attr_accessor :shit_mine_count

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
    update_shit_mines
  end

  def update_sync_data
    @role.update_lv @user_service.lv, @user_service.exp

    if GameConfig::DEBUG
      init_test_equipments
    else
      @wears = @user_service.wears
    end

    @role.rubbish_bin.update(@user_service.rubbishes)
    @role.nutrient_bin.update(@user_service.nutrients)
  end

  def init_test_equipments
    #[39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 90, 91, 604, 828,
    # 96, 97, 103, 104, 108, 109, 114, 115, 119, 121
    [
        #138, 228, 301, 402, 450, 552, 558, 569, 144, 163, 220,
        # 321, 322, 326, 327, 331, 332, 336, 340, 345, 346, 354, 359,
        # 168, 172, 178, 188, 222, 433, 497, 514, 574, 598, 708, 723,
        # 697, 710, 711, 802, 402, 521, 662, 376, 456, 381, 439,
        # 450, 192, 461
        # 125, 126, 127, 132, 133, 139, 143, 148, 149, 153, 154, 159, 160

        # 167, 173, 177, 181, 185, 191, 194, 195, 198, 199, 203, 204, 206, 207,
        # 211, 212, 216, 217, 221, 229, 235, 239, 240, 244, 245, 249, 250, 254,
        # 255, 259, 260, 264, 265, 269, 270, 274, 275, 279, 280, 285, 286, 290,
        # 291, 295, 296, 300
        305, 306, 310, 311, 314, 315, 320, 337, 341, 350,
        351, 353, 360, 364, 365, 367, 368, 372, 373, 377,
        382, 387, 388
    ].each do |num|
      vehicle_key = "vehicle_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
    end

    # [10, 24, 26, 35, 39, 41, 43, 69, 119
    # ].each do |num|
    #   vehicle_key = "vehicle2_#{num}".to_sym
    #   @role.add_equipment Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
    # end

    # %w(DragonRed DragonBlack DragonBlue).each do |dragon|
    #   dragon_key = "dragon_#{dragon}".to_sym
    #   @role.add_equipment Equipment.new(Equipment::Type::VEHICLE, dragon_key)
    # end

    PetTypeInfo.all_pet_types.each do |pet_type|
      @role.pet_package << Pet.new(SecureRandom.uuid, pet_type, 200, 200)
    end

    [1, 17, 20, 21, 97, 282].each do |num|
      key = "eye_wear_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::EYE_WEAR, key)
    end

    [#1, 8, 9, 29, 32, 53, 62, 69, 226, 261, 281, 357, 375
        369, 378, 411, 421, 431, 448, 487, 501, 511, 523, 528, 542, 553, 566,
        596, 605, 614, 799, 812, 829
    ].each do |num|
      key = "eye_wear2_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::EYE_WEAR, key)
    end

    [16, 48, 51, 52, 94, 130, 131, 253, 278, 316, 338, 355,
     394, 430, 467, 486, 559, 587, 617, 686, 715, 772, 795, 819].each do |num|
      key = "wing_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::WING, key)
    end

    [13, 15, 16].each do |num|
      key = "wing2_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::WING, key)
    end

    [
        # 2, 18, 20, 21, 22, 24, 37, 38, 392, 395,
        # 5, 10, 12, 14, 25, 26, 27, 34, 35, 36, 41, 43, 45, 46, 47, 49, 56, 61,
        # 66, 68, 72, 73, 80, 85, 86, 88, 93, 95, 100, 101,
        # 105, 107, 111, 113, 118, 120, 122, 123, 124, 129, 135, 136, 141, 142,
        # 145, 147, 150, 152, 156, 157,
        # 158, 162, 166, 170, 171,
        # 423
        175, 176, 180, 183, 184, 187, 189, 190, 193, 197,
        201, 202, 205, 209, 210, 214, 219, 223, 227, 231,
        233, 236, 238, 242, 243, 247, 248, 257, 258, 262,
        263, 267, 268
    ].each do |num|
      key = "hat_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::HAT, key)
    end

    [#12, 23, 25, 42, 47, 49
        2, 5, 9, 14, 28, 30, 37, 38, 40, 45, 48, 51, 54, 59, 68, 72, 130
    ].each do |num|
      key = "hat2_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::HAT, key)
    end

    [#13, 17, 102, 234, 349, 418, 443, 454, 471,
        485, 492, 508, 526, 532, 550].each do |num|
      key = "underpan_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::UNDERPAN, key)
    end

    [#3, 23, 42, 44, 54, 60, 65, 71, 76, 77, 87, 106, 232, 684, 689
        110, 112, 117, 128, 137, 146, 151, 218, 323, 328, 333, 356, 366, 428, 483,
        530, 535, 541, 565, 567, 571, 591
    ].each do |num|
      key = "handheld_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::HANDHELD, key)
    end

    [266, 292, 342, 352, 361, 379, 384, 403, 414, 427, 463,].each do |num|
      key = "ear_wear_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::EAR_WEAR, key)
    end

    [#7, 19, 55, 64, 79, 213, 225
        251, 297, 347, 415, 420, 435, 445, 536].each do |num|
      key = "background_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::BACKGROUND, key)
    end

    [#57, 63, 70, 78, 84,
     #92, 98, 99, 116, 134, 140, 161, 164, 179, 186, 196, 208, 215, 224, 230, 237, 241
     246, 252, 256, 271, 287, 302, 307, 317, 383, 389, 398, 426, 447, 451, 457, 464, 482,
     488, 493, 494, 499, 505, 522, 546, 561, 576, 590, 595, 619, 624, 629, 633, 639
    ].each do |num|
      key = "foreground_#{num}".to_sym
      @role.add_equipment Equipment.new(Equipment::Type::FOREGROUND, key)
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
    @role.clear_all_equipment
    vehicle_equipments = YecaiWebClient.get_vehicles_by_user_id(@user_id)
    if !vehicle_equipments.nil? && vehicle_equipments.length != 0
      vehicle_equipments.each { |equipment| @role.add_equipment equipment }
    end

    equipments = YecaiWebClient.get_equipments_by_user_id(@user_id)
    if !equipments.nil? && equipments.length != 0
      equipments.each { |equipment| @role.add_equipment equipment }
    end
  end

  def update_shit_mines
    if GameConfig::DEBUG
      @shit_mine_count = 100
    else
      @shit_mine_count = YecaiWebClient.get_user_shit_mine_count(@user_id)
    end
  end
end