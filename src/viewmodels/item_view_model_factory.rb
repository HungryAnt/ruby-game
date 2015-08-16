class ItemViewModelFactory
  def self.create_item_vm(item_map)
    case item_map['item_type']
      when Item::ItemType::FOOD
        create_food_vm(item_map)
    end
  end

  private

  def self.create_food_vm(item_map)
    id = item_map['id']
    x, y = item_map['x'].to_i, item_map['y'].to_i
    food_type_id = item_map['food_type_id'].to_i
    food = Food.new(id, x, y, food_type_id)
    food_vm = FoodViewModel.new(food)
    food_vm
  end

  def self.create_rubbish_vm

  end
end