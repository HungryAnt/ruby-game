require 'set'

class ShoppingViewModel
  PAGE_SIZE = 9

  def initialize
    autowired(ShoppingService, PlayerService, UserEquipmentService)
  end

  def get_goods(category, page_no)
    page_result = @shopping_service.get_goods(category, page_no, PAGE_SIZE)
    package_vehicle_keys_set = get_package_vehicle_keys_set
    package_pet_keys_set = get_package_pet_keys_set

    items = []
    page_result.page.result.map do |data_map|
      goods = Goods.from_map data_map
      key = goods.key.to_sym
      image = EquipmentDefinition.get_item_image key
      items << {
          key: key,
          image: image,
          price: goods.price,
          existing: package_vehicle_keys_set.include?(key) || package_pet_keys_set.include?(key)
      }
    end
    page_count = (page_result.page.total_count + PAGE_SIZE - 1) / PAGE_SIZE
    return items, page_count
  end

  def get_package_vehicle_keys_set
    vehicles = find_packege_items Equipment
    Set.new vehicles.map {|vehicle| vehicle.key}
  end

  def get_package_pet_keys_set
    pets = @player_service.role.pet_package.items
    Set.new pets.map {|pet| pet.pet_type}
  end

  def buy(key)
    @shopping_service.buy(@player_service.user_id, key)
    @user_equipment_service.update
    @player_service.update_pets
  end

  def apply_gift_vehicle
    @shopping_service.apply_gift_vehicle @player_service.user_id
  end

  def convert_to_money
    @shopping_service.convert_to_money @player_service.user_id
    @player_service.clear_rubbishes
  end

  private

  def find_packege_items(clazz)
    @player_service.role.package.items.find_all {|item| item.instance_of? clazz}
  end
end