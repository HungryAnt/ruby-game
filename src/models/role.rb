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
  include Mana
  include VehicleSpeed

  attr_accessor :state, :durable_state, :direction, :role_type,
                :hp, :vehicle, :battered, :battered_by_hit_type
  attr_reader :name, :rubbish_bin, :nutrient_bin, :pet_package

  def initialize(name, role_type, x, y)
    @name = name
    @role_type = role_type
    init_location x, y
    init_movable 4.2
    init_hp
    init_exp
    init_mana
    init_vehicle_speed

    init_packages

    @eating_food = nil
    @state = State::STANDING
    @durable_state = State::STANDING
    @direction = Direction::DOWN
    @intake = GameConfig::ROLE_INTAKE
    @temp_eating_food_exp = {}

    @rubbish_bin = RubbishBin.new
    @nutrient_bin = NutrientBin.new

    @battered = false  # 被打扁的
    @battered_by_hit_type = Role::State::HIT

    @wearing_equipments = {}
  end

  def equip(equipment_type, equipment)
    @wearing_equipments[equipment_type] = equipment
  end

  def un_equip(equipment_type)
    equip equipment_type, nil
  end

  def update_vehicle_speed
    update_speed(@equipment_packages[Equipment::Type::VEHICLE].items)
  end

  def init_wearing_equipments
    Equipment.role_equipment_types.each do |equipment_type|
      @wearing_equipments[equipment_type] = nil
    end
  end

  def init_packages
    @pet_package = Package.new 100

    @equipment_packages = {}
    Equipment.role_equipment_types.each do |equipment_type|
      @equipment_packages[equipment_type] = Package.new 200
    end
  end

  def clear_equipment(equipment_type)
    @equipment_packages[equipment_type].clear
  end

  def clear_all_equipment
    @equipment_packages.values.each { |package| package.clear }
  end

  def add_equipment(equipment)
    @equipment_packages[equipment.type] << equipment
  end

  def get_equipments(equipment_type)
    @equipment_packages[equipment_type].items
  end

  def get_all_equipment_keys
    keys_set = Set.new
    @equipment_packages.values.each do |package|
      package.items.each do |equipment|
        keys_set.add equipment.key
      end
    end
    keys_set
  end

  def equipment_packages
    @equipment_packages.values
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
    @wearing_equipments.values.each do |equipment|
      next if equipment.nil? || equipment.speed_up.nil?
      next if equipment.type == Equipment::Type::VEHICLE # 更改，车辆速度计算方式调整
      speed_rate += equipment.speed_up
    end

    vehicle_equipment = @wearing_equipments[Equipment::Type::VEHICLE]
    unless vehicle_equipment.nil?
      if vehicle_equipment.is_dragon? # 载具为龙
        speed_rate += vehicle_equipment.speed_up
      else
        speed_rate += @vehicle_speed
      end
    end

    @speed * speed_rate
  end

  def get_miss
    miss = 0
    @wearing_equipments.values.each do |equipment|
      next if equipment.nil? || equipment.miss.nil?
      miss = equipment.miss if equipment.miss > miss
    end
    miss
  end

  def move_to_location(x, y)
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
        food_id = @eating_food.id
        if @temp_eating_food_exp.include? food_id
          @temp_eating_food_exp[food_id] += intake
        else
          @temp_eating_food_exp[food_id] = intake
        end
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

  def update_eating_food(origin_x, origin_y, scale_value)
    food = @eating_food
    return if food.nil?

    if holding_food?
      food.visible = true
      food.x, food.y = origin_x, origin_y-21*scale_value
      food.covered = @direction == Direction::UP
      return
    end

    if @direction == Direction::UP
      food.visible = false
    else
      food.visible = true

      if Direction::is_direct_to_down @direction
        food.x, food.y = origin_x, origin_y + 30*scale_value
      end

      if Direction::is_direct_to_left @direction
        food.x, food.y = origin_x-27*scale_value, origin_y + 22*scale_value
      end

      if Direction::is_direct_to_right @direction
        food.x, food.y = origin_x+32*scale_value, origin_y + 22*scale_value
      end
    end
  end

  def holding_food?
    @state == State::HOLDING_FOOD
  end

  def query_and_dec_temp_exp
    food_exp_infos = []
    @temp_eating_food_exp.each_pair do |food_id, exp|
      exp_int_value = exp.to_i
      if exp_int_value > 0
        @temp_eating_food_exp[food_id] -= exp_int_value
        food_exp_infos << { food_id: food_id, exp: exp_int_value }
      end
    end
    food_exp_infos
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
    map = {
        role_type: @role_type.to_s,
        name: @name,
        x: @x,
        y: @y,
        hp: @hp,
        lv: @lv,
        state: @state.to_s,
        durable_state: @durable_state.to_s,
        direction: @direction,
        vehicle_speed: @vehicle_speed
    }
    Equipment.role_equipment_types.each do |equipment_type|
      equipment = @wearing_equipments[equipment_type]
      map[equipment_type] = equipment.nil? ? '' : equipment.key.to_s
    end
    map
  end
end