# coding: UTF-8

require_relative 'visible'
require_relative 'food_type_info'

class Food < Item
  include Visible
  attr_accessor :eating, :covered
  attr_reader :energy, :max_energy

  def initialize(id, x, y, food_type_id)
    init_item(id, Item::ItemType::FOOD, x, y)
    init_visible
    @food_type_info = FoodTypeInfo.get(food_type_id)
    @eating = false
    @covered = false
    @max_energy = @energy = @food_type_info.energy
  end

  def eatable?
    true
  end

  def image_path
    @food_type_info.image_path
  end

  # 食用 intake:摄取量
  def eat(intake)
    actual_intake = [@energy, intake].min
    @energy -= actual_intake
    actual_intake
  end

  def to_map
    item_map = super
    item_map['food_type_id'] = @food_type_info.id
    item_map
  end
end