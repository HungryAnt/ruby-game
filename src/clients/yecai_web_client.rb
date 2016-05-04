class YecaiWebClient
  def self.get_pets_by_user_id(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'pet/'
    http_client.params(userId: user_id)
    res = http_client.get
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      # raise RuntimeError.new("res.code: #{res.code}")
      return []
    end
    user_pets_list = JSON.parse(res.body)
    return [] if user_pets_list.nil? || user_pets_list.length == 0
    pets = []
    user_pets_list.each do |user_pet|
      pet = Pet.new(user_pet['petId'], user_pet['petType'].to_sym, 200, 200)
      level = user_pet['level']
      pet.update_lv_exp level['lv'].to_i, level['expInLv'].to_i, level['maxExpInLv'].to_i
      pets << pet
    end
    pets
  end

  def self.get_vehicles_by_user_id(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'vehicle/getVehicles'
    http_client.params(userId: user_id)
    res = http_client.get
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      raise RuntimeError.new("res.code: #{res.code}")
    end
    vehicles = JSON.parse(res.body)
    vehicles.map do |vehicle_keys|
      Equipment.new(Equipment::Type::VEHICLE, vehicle_keys.to_sym)
    end
  end

  def self.get_equipments_by_user_id(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'userEquipment/'
    http_client.params(userId: user_id)
    res = http_client.get
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      return []
    end

    raw_equipments = JSON.parse(res.body)
    raw_equipments.map do |raw_equipment|
      equipment_type = StringUtil.camel_to_underline raw_equipment['equipmentType']
      equipment_key = raw_equipment['equipmentKey']
      Equipment.new(equipment_type.to_sym, equipment_key.to_sym)
    end
  end

  def self.get_user_shit_mine_count(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'shitMine/count'
    http_client.params(userId: user_id)
    res = http_client.get
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      return 0
    end
    res.body.to_i
  end
end