require_relative 'location'
require_relative 'hp'
require_relative 'exp'
require_relative 'package'

class Role
  class State
    STANDING = :stand
    WALKING = :walk
    RUNNING = :run
    EATING = :eat
    HOLDING_FOOD = :hold_food
  end

  include Location
  include Hp
  include Exp

  attr_accessor :state, :direction
  attr_reader :package

  def initialize(x, y)
    init_location x, y
    init_hp
    init_exp

    @package = Package.new 100
    @eating_food = nil
    @state = State::STANDING
    @direction = Direction::DOWN
  end

  def eat(food)
    @eating_food = food
    food.eating = true
    @state = State::EATING
  end

  def eating
    !@eating_food.nil?
  end

  def update_eating_food
    food = @eating_food
    return if food.nil?
    if @direction == Direction::UP
      food.visible = false
    else
      food.visible = true
      if Direction::is_direct_to_down @direction
        food.x, food.y = @x, @y+25
      end

      if Direction::is_direct_to_left @direction
        food.x, food.y = @x-35, @y+23
      end

      if Direction::is_direct_to_right @direction
        food.x, food.y = @x+35, @y+23
      end
    end
  end
end