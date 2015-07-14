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

  attr_accessor :state
  attr_reader :package

  def initialize(x, y)
    init_location x, y
    init_hp
    init_exp

    @package = Package.new 100
    @eating_food = nil
    @state = State::STANDING
  end

  def eat(food)
    @eating_food = food
    @state = State::EATING
  end
end