require_relative 'location'
require_relative 'movable'

class Pet
  module State
    STAND = :stand
    MOVE = :move
    ATTACK = :attack
    SLEEP = :sleep
    CUTE = :cute # ¬Ù√»

    ALL_STATES = [STAND, MOVE, ATTACK, SLEEP, CUTE]
  end

  attr_accessor :pet_type, :state, :durable_state

  include Location
  include Movable

  def initialize(pet_type, name, x, y)
    init_location x, y
    init_movable 5, false
    @pet_type = pet_type
    @name = name
    @state = State::STAND
    @durable_state = State::STAND
  end

end