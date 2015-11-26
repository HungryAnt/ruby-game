require_relative 'location'
require_relative 'movable'
require_relative 'hp'
require_relative 'exp'
require_relative 'package'

class Role
  module State
    STANDING = :stand
    WALKING = :walk
    RUNNING = :run
    EATING = :eat
    HOLDING_FOOD = :hold_food
    DRIVING = :drive
    HIT = :hit # 砸人与砸大型垃圾都是HIT
    TURN_TO_BATTERED = :turn_to_battered
    BATTERED = :battered
    COLLECTING_RUBBISH = :collecting_rubbish

    SCARE = :scare
    LECHEROUS = :lecherous
    BYE = :bye
    CRY = :cry
    LAUGH = :laugh
    FINGER_HIT = :finger_hit
    HEAD_HIT = :head_hit
    FART = :fart

    TURN_TO_FINGER_BATTERED = :turn_to_finger_battered
    FINGER_BATTERED = :finger_battered

    TURN_TO_STUNNED = :turn_to_stunned
    STUNNED = :stunned

    CAST = :cast  # 投掷（魔法球）
    ARROGANT = :arrogant  # 傲慢
    WORRY = :worry  # 着急
    HAPPY = :happy
    ROLL = :roll  # 打滚
    SLEEP = :sleep
  end

  module Action
    APPEAR = :appear
    DISAPPEAR = :disappear
    AUTO_MOVE_TO = :auto_move_to
  end

  include Location
  include Movable
  include Hp
  include Exp

  attr_accessor :state, :durable_state, :direction, :role_type,
                :hp, :vehicle, :driving, :battered, :battered_by_hit_type
  attr_reader :package, :name, :rubbish_bin, :nutrient_bin, :pet_package

  def initialize(name, role_type, x, y)
    @name = name
    @role_type = role_type
    init_location x, y
    init_movable 4.2
    init_hp
    init_exp

    @package = Package.new 100
    @pet_package = Package.new 100

    @eating_food = nil
    @state = State::STANDING
    @durable_state = State::STANDING
    @direction = Direction::DOWN
    @intake = GameConfig::ROLE_INTAKE
    @temp_exp = 0

    @vehicle = nil
    @driving = false

    @rubbish_bin = RubbishBin.new
    @nutrient_bin = NutrientBin.new

    @battered = false  # 被打扁的
    @battered_by_hit_type = Role::State::HIT
  end

  def get_speed
    if @battered
      return 0 if HitTypeDefinition.cannot_move? @battered_by_hit_type
    end

    @running = @hp > 0

    running = @running && !@battered
    speed_rate = 1.0
    speed_rate -= 0.5 unless running
    speed_rate -= 0.25 if @battered || eating?
    speed_rate += @vehicle.speed_up if driving && !@vehicle.nil?
    @speed * speed_rate
  end

  def move_to_location(x, y)
    # @role.standing = false
    # @role.x = x
    # @role.y = y
    super
    dec_hp(GameConfig::RUNNING_HP_DEC) if @running
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

  # def refresh_exp
  #   if @temp_exp > 0
  #     inc_exp(@temp_exp)
  #     @temp_exp = 0
  #   end
  # end

  def query_and_dec_temp_exp
    exp = @temp_exp.to_i
    @temp_exp -= exp
    exp
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
        durable_state: @durable_state.to_s,
        direction: @direction,
        vehicle: (!@vehicle.nil? ? @vehicle.key: '') # "vehicle_#{id}"
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