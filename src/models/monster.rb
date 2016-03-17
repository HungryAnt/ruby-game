require_relative 'location'
require_relative 'movable'
require_relative 'monster_type_info'

class Monster
  ENEMY_TYPE = :monster

  module State
    STAND = :stand
    MOVE = :move
    ATTACK = :attack
    CAPITULATE = :capitulate

    ALL_STATES = [STAND, MOVE, ATTACK, CAPITULATE]
  end

  attr_accessor :state, :durable_state
  attr_reader :id, :monster_type_id, :name, :max_hp, :hp, :height, :monster_type_info

  include Location
  include Movable

  def initialize(id, monster_type_id, max_hp, hp, x, y)
    init_location x, y
    init_movable 3, false
    @id = id
    @monster_type_id = monster_type_id
    @state = State::STAND
    @durable_state = State::STAND
    @max_hp, @hp = max_hp, hp
    refresh
  end

  def update_hp(hp)
    @hp = hp
  end

  def refresh
    monster_type_info = MonsterTypeInfo.get monster_type_id
    @monster_type_info = monster_type_info
    @name = monster_type_info.name
    @height = monster_type_info.height
  end
end