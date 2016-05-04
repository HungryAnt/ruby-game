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

  attr_accessor :state, :durable_state
  attr_reader :pet_id, :pet_type

  include Location
  include Movable
  include LevelExp

  def initialize(pet_id, pet_type, x, y)
    init_location x, y
    init_movable 5, false
    init_level_exp 1, 0, 100
    @pet_id = pet_id
    @pet_type = pet_type
    @state = State::STAND
    @durable_state = State::STAND
  end

  def to_map
    {
        pet_id: @pet_id,
        pet_type: @pet_type.to_s,
        x: @x,
        y: @y,
        state: @state.to_s,
        durable_state: @durable_state.to_s,
        direction: @direction
    }
  end
end