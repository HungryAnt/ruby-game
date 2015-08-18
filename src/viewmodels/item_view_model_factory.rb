class ItemViewModelFactory
  def self.create_item_vm(item_map)
    case item_map['item_type']
      when Item::ItemType::FOOD
        create_food_vm(item_map)
    end
  end

  def self.create_simple_food_vm(food_type_id)
    food = Food.new('', 0, 0, food_type_id, 999)
    food_vm = FoodViewModel.new(food)
    food_vm
  end

  private

  def self.create_food_vm(item_map)
    id = item_map['id']
    x, y = item_map['x'].to_i, item_map['y'].to_i
    food_type_id = item_map['food_type_id'].to_i
    energy = item_map['energy'].to_f
    food = Food.new(id, x, y, food_type_id, energy)
    food_vm = FoodViewModel.new(food)
    food_vm
  end

  def self.create_rubbish_vm

  end
end