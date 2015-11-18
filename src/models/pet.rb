require_relative 'location'
require_relative 'movable'

class Pet
  module State
    STAND = :stand
    MOVE = :move
    ATTACK = :attack
    SLEEP = :sleep
    CUTE = :cute # ����

    ALL_STATES = [STAND, MOVE, ATTACK, SLEEP, CUTE]
  end

  attr_accessor :pet_type, :state, :durable_state

  include Location
  include Movable

  def initialize(name, pet_type, x, y)
    init_location x, y
    init_movable 5, false
    @name = name
    @pet_type = pet_type
    @state = State::STAND
    @durable_state = State::STAND
  end

end