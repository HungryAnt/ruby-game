class ShoppingViewModel
  PAGE_SIZE = 9

  def initialize
    autowired(ShoppingService)
  end

  def get_vehicle_goods(page_no)
    page_result = @shopping_service.get_vehicles(page_no, PAGE_SIZE)
    return [] if page_result.nil?
    items = []
    page_result.page.result.map do |data_map|
      goods = Goods.from_map data_map
      image = EquipmentDefinition.get_item_image goods.key.to_sym
      items << {
          # key: goods.key,
          image: image,
          price: goods.price
      }
    end
    page_count = page_result.page.total_count / PAGE_SIZE
    return items, page_count
  end
end