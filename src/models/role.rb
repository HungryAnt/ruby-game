require_relative 'location'
require_relative 'hp'
require_relative 'exp'
require_relative 'package'

class RoleType
  WAN_GYE = :wangye
  SALARY = :salary
end

class Role
  class State
    STANDING = :stand
    WALKING = :walk
    RUNNING = :run
    EATING = :eat
    HOLDING_FOOD = :hold_food
  end

  class Action
    APPEAR = :appear
    DISAPPEAR = :disappear
    AUTO_MOVE_TO = :auto_move_to
  end

  include Location
  include Hp
  include Exp

  attr_accessor :state, :direction, :role_type, :hp
  attr_reader :package, :name

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

  def update_eating_food
    food = @eating_food
    return if food.nil?

    if holding_food?
      food.visible = true
      food.x, food.y = @x, @y-51
      food.covered = @direction == Direction::UP
      return
    end

    if @direction == Direction::UP
      food.visible = false
    else
      food.visible = true

      if Direction::is_direct_to_down @direction
        food.x, food.y = @x, @y
      end

      if Direction::is_direct_to_left @direction
        food.x, food.y = @x-35, @y
      end

      if Direction::is_direct_to_right @direction
        food.x, food.y = @x+35, @y
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
        direction: @direction
    }
  end

  def from_map(map)
    role = Role(map['name'], map['role_type'].to_sym, map['x'].to_i, map['y'].to_i)
    role.hp = map['hp'].to_i
    role.update_lv(map['lv'].to_i, 0)
    role.state = map['state'].to_sym
    role.direction = map['direction'].to_i
  end
end