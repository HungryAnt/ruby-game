# coding: UTF-8

require_relative 'nutrient_type_info'

class Nutrient < Item
  attr_reader :nutrient_type_id

  def initialize(id, x, y, nutrient_type_id)
    init_item(id, Item::ItemType::RUBBISH, x, y)
    @nutrient_type_id = nutrient_type_id
    @nutrient_type_info = NutrientTypeInfo.get(nutrient_type_id)
  end

  def image_path
    @nutrient_type_info.image_path
  end

  def to_nutrient_map
    {
        nutrient_type_id: @nutrient_type_info.id
    }
  end
end