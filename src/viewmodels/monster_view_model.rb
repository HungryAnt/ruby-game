class MonsterViewModel
  attr_reader :monster

  def initialize(monster)
    autowired(WindowResourceService)
    @monster = monster
    @height = 50
    init_animations
  end

  def draw
    draw_anim
  end

  def y
    @monster.y
  end

  def move_to(x, y)
    @monster.set_auto_move_to x, y
  end

  def update(area)
    @monster.auto_move area
    update_state
  end

  def set_durable_state(state)
    @monster.durable_state = state
    if state == Pet::State::ATTACK
      anim_goto_begin
    end
  end

  private

  def init_animations
    monster_type = @monster.monster_type.to_s
    Monster::State::ALL_STATES.each do |state|
      %w(left right up down down_right).each do |direction|
        self.instance_variable_set(
            "@anim_#{state}_#{direction}",
            AnimationManager.get_anim("#{monster_type}_#{state}_#{direction}".to_sym))
      end
    end
    @current_anim = @anim_stand_down
    anim_goto_begin
  end

  def draw_anim
    x, y = get_actual_pet_location
    @current_anim.draw(x, y, ZOrder::Player, init_timestamp:@anim_init_timestamp)
  end

  def anim_goto_begin
    @anim_init_timestamp = Gosu::milliseconds
  end

  def get_actual_pet_location
    [@monster.x, @monster.y - @height]
  end

  def update_state
    set_state get_state
  end

  def set_state(state)
    @monster.state = state
    change_anim
  end

  def get_state
    if @monster.standing
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
end