require_relative 'location'
require_relative 'hp'
require_relative 'exp'
require_relative 'package'

class RoleType
  WAN_GYE = :wangye # 鸡蛋
  SALARY = :salary
  BANGYE = :bangye # 半个鸡蛋
  DOOBU = :doobu
  KIMCHI = :kimchi
  MANL = :manl
  MOO = :moo
  PASERY = :pasery
  PIMENTO = :pimento
  RICE = :rice
  YANGBEA = :yangbea
  YANGPA = :yangpa

  @@all_role_types = [WAN_GYE, SALARY, BANGYE, DOOBU, KIMCHI, MANL, MOO, PASERY, PIMENTO, RICE, YANGBEA, YANGPA]
  @@roles_len = @@all_role_types.length

  def self.default
    YANGPA
  end

  def self.get_all_types
    @@all_role_types
  end

  def self.random
    @@all_role_types[rand(@@roles_len)]
  end

  def self.next(role_type)
    next_index = (get_index_of(role_type) + 1) % @@roles_len
    @@all_role_types[next_index]
  end

  def self.prev(role_type)
    preve_index = (get_index_of(role_type) - 1 + @@roles_len) % @@roles_len
    @@all_role_types[preve_index]
  end

  def self.get_index_of(role_type)
    0.upto(@@roles_len  - 1) {|i| return i if role_type == @@all_role_types[i]}
    return -1
  end

  def self.from(role_type_text)
    return default if role_type_text.nil? || role_type_text.chomp == ''
    role_type = role_type_text.to_sym
    return default if get_index_of(role_type) < 0
    role_type
  end
end

class Role
  class State
    STANDING = :stand
    WALKING = :walk
    RUNNING = :run
    EATING = :eat
    HOLDING_FOOD = :hold_food
    DRIVING = :drive
    HIT = :hit
    TURN_TO_BATTERED = :turn_to_battered
    BATTERED = :battered
    COLLECTING_RUBBISH = :collecting_rubbish
  end

  class Action
    APPEAR = :appear
    DISAPPEAR = :disappear
    AUTO_MOVE_TO = :auto_move_to
  end

  include Location
  include Hp
  include Exp

  attr_accessor :state, :direction, :role_type, :hp, :vehicle
  attr_reader :package, :name, :rubbish_bin

  def initialize(name, role_type, x, y)
    @name = name
    @role_type = role_type
    init_location x, y
    init_hp
    init_exp

    @package = Package.new 100
    @eating_food = nil
    @state = State::STANDING
    @direction = Direction::DOWN
    @intake = GameConfig::ROLE_INTAKE
    @temp_exp = 0
    @vehicle = nil  # "vehicle_#{id}"
    @rubbish_bin = RubbishBin.new
  end

  def start_eat(food)
    @eating_food = food
    food.eating = true
  end

  def eat
    if eating?
      intake = @eating_food.eat @intake
      if intake > 0
        # inc_exp intake
        @temp_exp += intake
      else
        eat_done
      end
    end
  end

  # 食物已经吃完
  def eat_done
    @eating_food = nil
  end

  def eating?
    !@eating_food.nil?
  end

  def update_eating_food(origin_x, origin_y)
    food = @eating_food
    return if food.nil?

    if holding_food?
      food.visible = true
      food.x, food.y = origin_x, origin_y-21
      food.covered = @direction == Direction::UP
      return
    end

    if @direction == Direction::UP
      food.visible = false
    else
      food.visible = true

      if Direction::is_direct_to_down @direction
        food.x, food.y = origin_x, origin_y + 30
      end

      if Direction::is_direct_to_left @direction
        food.x, food.y = origin_x-27, origin_y + 22
      end

      if Direction::is_direct_to_right @direction
        food.x, food.y = origin_x+32, origin_y + 22
      end
    end
  end

  def holding_food?
    @state == State::HOLDING_FOOD
  end

  def refresh_exp
    if @temp_exp > 0
      inc_exp(@temp_exp)
      @temp_exp = 0
    end
  end

  def discard
    item = nil
    if eating?
      item = @eating_food
      @eating_food = nil
      item.visible = true
      item.eating = false
      item.x, item.y = @x, @y
    end
    item
  end

  def to_map
    {
        role_type: @role_type.to_s,
        name: @name,
        x: @x,
        y: @y,
        hp: @hp,
        lv: @lv,
        state: @state.to_s,
        direction: @direction,
        vehicle: @vehicle
    }
  end

  def from_map(map)
    role = Role(map['name'], map['role_type'].to_sym, map['x'].to_i, map['y'].to_i)
    role.hp = map['hp'].to_i
    role.update_lv(map['lv'].to_i, 0)
    role.state = map['state'].to_sym
    role.direction = map['direction'].to_i
    # role.speed = map['speed'].to_f
  end
end