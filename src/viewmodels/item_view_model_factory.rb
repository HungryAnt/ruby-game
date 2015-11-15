class ItemViewModelFactory
  def self.create_item_vm(item_map)
    case item_map['item_type']
      when Item::ItemType::FOOD
        create_food_vm item_map
      when Item::ItemType::RUBBISH
        create_rubbish_vm item_map
      when Item::ItemType::NUTRIENT
        create_nutrient_vm item_map
    end
  end

  def self.create_simple_food_vm(food_type_id)
    food = Food.new('', 0, 0, food_type_id, 999, 999)
    food_vm = FoodViewModel.new(food)
    food_vm
  end

  # def self.create_simple_rubbish_vm(rubbish_type_id)
  #   rubbish = Rubbish.new()
  #   rubbish_vm = RubbishViewModel.new(rubbish)
  #   rubbish_vm
  # end

  private

  def self.create_food_vm(item_map)
    id, x, y = item_map['id'], item_map['x'].to_i, item_map['y'].to_i
    food_type_id = item_map['food_type_id'].to_i
    max_energy = item_map['max_energy'].to_f
    energy = item_map['energy'].to_f
    food = Food.new(id, x, y, food_type_id, max_energy, energy)
    food_vm = FoodViewModel.new(food)
    food_vm
  end

  def self.create_rubbish_vm(item_map)
    id, x, y = item_map['id'], item_map['x'].to_i, item_map['y'].to_i
    rubbish_type_id = item_map['rubbish_type_id'].to_i
    rubbish = Rubbish.new(id, x, y, rubbish_type_id)
    rubbish_vm = RubbishViewModel.new rubbish
    rubbish_vm
  end

  def self.create_nutrient_vm(item_map)
    id, x, y = item_map['id'], item_map['x'].to_i, item_map['y'].to_i
    nutrient_type_id = item_map['nutrient_type_id'].to_i
    nutrient = Nutrient.new(id, x, y, nutrient_type_id)
    nutrient_vm = NutrientViewModel.new nutrient
    nutrient_vm
  end
end