require 'set'

class ShoppingViewModel
  PAGE_SIZE = 9

  def initialize
    autowired(ShoppingService, PlayerService, UserEquipmentService)
  end

  def get_goods(category, page_no)
    page_result = @shopping_service.get_goods(category, page_no, PAGE_SIZE)
    package_pet_keys_set = get_package_pet_keys_set
    all_equipment_keys_set = get_all_equipment_keys_set

    items = []
    page_result.page.result.map do |data_map|
      goods = Goods.from_map data_map
      key = goods.key.to_sym
      image = EquipmentDefinition.get_item_image key
      anim = EquipmentDefinition.get_item_animation category, key
      items << {
          key: key,
          image: image,
          anim: anim,
          price: goods.price,
          existing: package_pet_keys_set.include?(key) || all_equipment_keys_set.include?(key),
          equipment_type: goods.equipment_type
      }
    end
    page_count = (page_result.page.total_count + PAGE_SIZE - 1) / PAGE_SIZE
    return items, page_count
  end

  def get_package_pet_keys_set
    pets = @player_service.role.pet_package.items
    Set.new pets.map {|pet| pet.pet_type}
  end

  def get_all_equipment_keys_set
    role = @player_service.role
    role.get_all_equipment_keys
  end

  def buy(key)
    @shopping_service.buy(@player_service.user_id, key)
    @user_equipment_service.update
    @player_service.update_pets
    @player_service.update_equipments
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