class MonsterViewModel < EnemyViewModel
  HP_BAR_WIDTH = 64
  HP_BAR_HEIGHT = 5
  HP_BAR_BORDER = 3

  EFFECT_ANIM_IMAGES_COUNT = 15
  ATTACKING_DURATION_IN_MS = EFFECT_ANIM_IMAGES_COUNT * 220 # 3300
  ATTACKING_INTERVAL_IN_S = 1

  EFFECT_ANIM_Y_OFFSET = 44

  CAPITULATE_DURING_TIME = 4000

  attr_reader :monster, :is_capitulate

  def initialize(monster)
    super(monster)
    autowired(WindowResourceService)
    @monster = monster
    init_animations
    @attack_begin_time = 0
    @one_attack_begin_time = 0
    @attack_update_times = 0

    @capitulate_time = 0
    @is_capitulate = false

    @update_times = 0
  end

  def enemy_type
    Monster::ENEMY_TYPE
  end

  def update_monster(monster)
    @monster = monster
    @enemy = monster
  end

  def update_hp(hp)
    @monster.update_hp hp
  end

  def draw
    draw_effect
    draw_anim

    unless @is_capitulate
      draw_name
      draw_hp
    end
  end

  def move_to(x, y)
    @monster.set_auto_move_to x, y
  end

  def update(area, player_vm)
    @monster.auto_move area

    if Gosu::milliseconds - @attack_begin_time < ATTACKING_DURATION_IN_MS
      if (@update_times - @attack_update_times) % (GameConfig::FPS * ATTACKING_INTERVAL_IN_S).to_i == 0
        do_one_attack player_vm
      end
    end

    update_state

    @anim_container.update

    if @is_capitulate
      rate = (Gosu::milliseconds - @capitulate_time).to_f / CAPITULATE_DURING_TIME
      if rate > 0 && rate <= 1
        @anim_color = Gosu::Color.new(0xFF - (0xFF * rate).to_i, 0xFF, 0xFF, 0xFF)
      end
    end

    @update_times += 1
  end

  def attack
    @attack_begin_time = Gosu::milliseconds
    @attack_update_times = @update_times
    anim_goto_begin

    # @anim_monster_attack_effect.goto_begin
    anim_holder = AnimationHolder.new @anim_monster_attack_effect,
                                      @monster.x, @monster.y - EFFECT_ANIM_Y_OFFSET, ZOrder::Player, false
    @anim_container << anim_holder
  end

  def capitulate
    @capitulate_time = Gosu::milliseconds
    @is_capitulate = true
    anim_goto_begin
  end

  def should_destroy?
    @is_capitulate && Gosu::milliseconds - @capitulate_time >= CAPITULATE_DURING_TIME
  end

  private

  def init_animations
    monster_type_id = @monster.monster_type_id.to_s
    Monster::State::ALL_STATES.each do |state|
      %w(left right up down down_right).each do |direction|
        self.instance_variable_set(
            "@anim_#{state}_#{direction}",
            AnimationManager.get_anim("#{monster_type_id}_#{state}_#{direction}".to_sym))
      end
    end
    @current_anim = @anim_stand_down
    anim_goto_begin

    @anim_monster_attack_effect = AnimationManager.get_anim :monster_attack_effect
    @anim_container = AnimationContainer.new

    @anim_color = 0xFF_FFFFFF
  end

  def draw_anim
    x, y = get_anim_center_location
    @current_anim.draw(x, y, ZOrder::Player, init_timestamp:@anim_init_timestamp, color:@anim_color)
    # Gosu::draw_rect(@monster.x, @monster.y, 1, 1, 0xFF_FF0000, ZOrder::Player)
  end

  def anim_goto_begin
    @anim_init_timestamp = Gosu::milliseconds
  end

  def get_anim_center_location
    [@monster.x, @monster.y - @monster.height / 2]
  end

  def update_state
    set_state get_state
  end

  def set_state(state)
    @monster.state = state
    change_anim
  end

  def get_state
    if @is_capitulate
      return Monster::State::CAPITULATE
    end
    if @monster.standing
      if in_attacking
        return Monster::State::ATTACK
      end
      @monster.durable_state
    else
      Monster::State::MOVE
    end
  end

  def change_anim
    state = @monster.state.to_s
    direction = Direction::to_direction_text(@monster.direction)
    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def draw_name
    font = @window_resource_service.get_font_16
    text_width = font.text_width(name)
    x = @monster.x - text_width / 2
    y = @monster.y + 21
    GraphicsUtil.draw_text_with_border(name, font, x, y,
                                       ZOrder::Player, 1, 1, 0xFF_F5CAA8, 0xEE_210B00)
  end

  def draw_hp
    rate = 1.0 * @monster.hp / @monster.max_hp
    current_hp_width = HP_BAR_WIDTH * rate
    x = @monster.x - HP_BAR_WIDTH / 2
    y = @monster.y + 15
    GraphicsUtil::draw_rect_border x-1, y-1, HP_BAR_WIDTH + 3, HP_BAR_HEIGHT + 3, 0xFF_F5CAA8, ZOrder::Player
    GraphicsUtil::draw_rect_border x, y, HP_BAR_WIDTH + 1, HP_BAR_HEIGHT + 1, 0xEE_210B00, ZOrder::Player

    c0 = Gosu::Color.new(0xFF, 0xEA, 0x53, 0x20)
    c1 = Gosu::Color.new(0xFF, 0xEA, 0x53 + ((0xF6 - 0x53) * rate).to_i, 0x20)
    GraphicsUtil::draw_linear_rect(x, y, current_hp_width, HP_BAR_HEIGHT,
                                   ZOrder::Player, c0, c1, direction:'hor')
  end

  def do_one_attack(player_vm)
    # ´¥·¢¹¥»÷Ñ£ÔÎ
    puts 'attack'
    player_vm.check_hit_battered Monster::State::ATTACK, @monster.x, @monster.y
  end

  def in_attacking
    Gosu::milliseconds - @attack_begin_time <= ATTACKING_DURATION_IN_MS
  end

  def draw_effect
    @anim_container.draw mode: :additive
  end
end