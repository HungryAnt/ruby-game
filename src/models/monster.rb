require_relative 'location'
require_relative 'movable'

class Monster
  module State
    STAND = :stand
    MOVE = :move
    ATTACK = :attack
    CAPITULATE = :capitulate

    ALL_STATES = [STAND, MOVE, ATTACK, CAPITULATE]
  end

  attr_accessor :state
  attr_reader :monster_id, :monster_type

  include Location
  include Movable

  def initialize(monster_id, monster_type, x, y)
    init_location x, y
    init_movable 5, false
    @monster_id = monster_id
    @monster_type = monster_type
    @state = State::STAND
  end

  def to_map
    {
        monster_id: @monster_id,
        monster_type: @monster_type.to_s,
        x: @x,
        y: @y,
        state: @state.to_s,
        direction: @direction
    }
  end
end