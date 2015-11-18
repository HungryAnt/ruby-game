class PetViewModel
  def initialize(pet)
    @pet = pet
    init_animations
    reset_durable_state
    @update_times = 0
  end

  def x
    @pet.x
  end

  def y
    @pet.y
  end

  def set_destination(target_x, target_y)
    reset_durable_state
    @pet.set_auto_move_to target_x, target_y
  end

  def auto_move(area)
    @pet.auto_move area
  end

  def update(area, role)
    @update_times += 1
    if rand(5 * GameConfig::FPS) == 0
      rand_num = rand 10
      if rand_num < 4
        move_random area
      elsif rand_num < 6
        move_to_owner role
      elsif rand_num < 9
        sleep
      end
    end
    auto_move area
    update_state
  end

  def move_random(area)
    set_destination *area.random_available_position
  end

  def move_to_owner(role)
    if Gosu::distance(x, y, role.x, role.y) < 20
      cute
    else
      set_destination *role_side_location(role)
    end
  end

  def attack

  end

  def sleep
    set_durable_state Pet::State::SLEEP
  end

  def cute
    set_durable_state Pet::State::CUTE
  end

  def draw
    draw_anim
  end

  def update_state
    set_state get_state
  end

  def set_durable_state(state)
    @pet.durable_state = state
    update_state
    if state == Pet::State::ATTACK || state == Pet::State::CUTE
      anim_goto_begin
    end
  end

  private

  def init_animations
    pet_type = @pet.pet_type.to_s
    Pet::State::ALL_STATES.each do |state|
      %w(left right up down down_right).each do |direction|
        self.instance_variable_set(
            "@anim_#{state}_#{direction}",
            AnimationManager.get_anim("#{pet_type}_#{state}_#{direction}".to_sym))
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
    [@pet.x, @pet.y - 20]
  end

  def set_state(state)
    @pet.state = state
    change_anim
  end

  def change_anim
    state = @pet.state.to_s
    direction = Direction::to_direction_text(@pet.direction)

    # 宠物素材特殊性，向右下方移动做不同效果展示
    if direction == 'down' && @pet.exact_direction == Direction::SOUTH_EAST
      @current_anim = self.instance_variable_get("@anim_#{state}_down_right")
      return unless @current_anim.nil?
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_state
    if @pet.standing
      return @pet.durable_state
    else
      return Pet::State::MOVE
    end
  end

  def reset_durable_state
    @pet.durable_state = Pet::State::STAND
  end

  def role_side_location(role)
    [role.x + 15 - rand(30), role.y + 1]
  end
end