# coding: UTF-8

require_relative 'location'
require_relative 'visible'
require_relative 'food_type'

class Food
  include Location
  include Visible

  attr_accessor :eating, :covered

  attr_reader :food_type

  def initialize(x, y, food_type)
    init_location x, y
    init_visible
    @food_type = food_type
    @eating = false
    @covered = false
    @energy = 100
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