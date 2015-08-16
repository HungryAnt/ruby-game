# coding: UTF-8

require_relative 'location'
require_relative 'visible'
require_relative 'food_type_info'

class Food < Item
  include Location
  include Visible

  attr_accessor :eating, :covered

  attr_reader :food_type, :energy, :max_energy

  def initialize(x, y, food_type_id)
    super(Item::ItemType::FOOD)
    init_location x, y
    init_visible
    @food_type = FoodTypeInfo.get(food_type_id)
    @eating = false
    @covered = false
    @max_energy = @energy = food_type.energy
  end

  def eatable?
    true
  end

  def image_path
    @food_type.image_path
  end

  # 食用 intake:摄取量
  def eat(intake)
    actual_intake = [@energy, intake].min
    @energy -= actual_intake
    actual_intake
  end
end