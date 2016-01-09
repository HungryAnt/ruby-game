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
      pets << Pet.new(user_pet['petId'], user_pet['petType'].to_sym, 200, 200)
    end
    pets
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
      equipment_type = raw_equipment['equipmentType'].gsub(/(.)([A-Z])/, '\1_\2').downcase
      equipment_key = raw_equipment['equipmentKey']
      Equipment.new(equipment_type.to_sym, equipment_key.to_sym)
    end
  end
end