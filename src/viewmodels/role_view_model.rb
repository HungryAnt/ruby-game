class RoleViewModel
  include AutoScaleModule

  attr_reader :role, :hitting
  attr_accessor :area_id, :vehicle_vm

  def initialize(role)
    autowired(MapService, HitService)
    init_auto_scale
    @player = @role = role
    @font = Gosu::Font.new(15)
    init_animations
    @eating_food_vm = nil
    @auto_move_enabled = false
    @speed = 5.3
    @arrive_call_back = nil
    stop
    @area_id = nil
    init_equipments
    @chat_bubble_vm = ChatBubbleViewModel.new
    @update_times = 0
    init_hit_components
    init_sound
    reset_durable_state
    @anim_init_timestamp = Gosu::milliseconds
  end

  def init_equipments
    @vehicle_vm = nil
    @eye_wear_vm = nil
    @wing_vm = nil
    @hat_vm = nil
    @underpan_vm = nil
  end

  def eye_wear_vm=(equipment_vm)
    @eye_wear_vm = equipment_vm.nil? ? nil : equipment_vm
    @role.eye_wear = equipment_vm.nil? ? nil : equipment_vm.equipment
  end

  def wing_vm=(equipment_vm)
    @wing_vm = equipment_vm.nil? ? nil : equipment_vm
    @role.wing = equipment_vm.nil? ? nil : equipment_vm.equipment
  end

  def hat_vm=(equipment_vm)
    @hat_vm = equipment_vm.nil? ? nil : equipment_vm
    @role.hat = equipment_vm.nil? ? nil : equipment_vm.equipment
  end

  def underpan_vm=(equipment_vm)
    @underpan_vm = equipment_vm.nil? ? nil : equipment_vm
    @role.underpan = equipment_vm.nil? ? nil : equipment_vm.equipment
  end

  def handheld_vm=(equipment_vm)
    @handheld_vm = equipment_vm.nil? ? nil : equipment_vm
    @role.handheld = equipment_vm.nil? ? nil : equipment_vm.equipment
  end

  def init_hit_components
    @hitting = false
  end

  def init_sound
    @sound_eat_food = MediaUtil::get_sample('eat.wav')
    @sound_collect_rubbish = MediaUtil::get_sample('collect_rubbish.wav')
    @sound_smash = MediaUtil.get_sample 'smash.wav'
    @sound_collect_nutrient = MediaUtil.get_sample 'collect_nutrient.wav'
  end

  def y
    @role.y
  end

  def driving?
    @role.driving && !@vehicle_vm.nil?
  end

  def wear_cloak?
    driving? && @vehicle_vm.is_cloak
  end

  def set_driving(value)
    @role.driving = value
    @role.vehicle = driving? ? @vehicle_vm.equipment : nil
    value
  end

  def driving
    @role.driving
  end

  def drive(vehicle_key)
    if vehicle_key.nil?
      set_driving false
      return
    end
    return if driving? && @vehicle_vm.key == vehicle_key
    @vehicle_vm = EquipmentViewModelFactory.create_vehicle vehicle_key
    set_driving true
  end

  def init_animations
    role_type = @role.role_type.to_s
    %w(stand walk run eat hold_food drive hit turn_to_battered battered
      collecting_rubbish scare lecherous bye cry laugh
      finger_hit turn_to_finger_battered finger_battered
      fart head_hit turn_to_stunned stunned
      cast arrogant worry happy roll sleep).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{role_type}_#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def appear_in_new_area
    @role.disable_auto_move
    update_state
  end

  def stop
    @role.stop
  end

  def eat_food(food_vm)
    @sound_eat_food.play
    eat_food_quietly food_vm
  end

  def eat_food_quietly(food_vm)
    @role.start_eat food_vm.food
    @eating_food_vm = food_vm
  end

  def clear_food
    @eating_food_vm = nil
    @role.eat_done
  end

  def collect_rubbish(quiet=false)
    @sound_collect_rubbish.play unless quiet
    @collecting_rubbish = true
    @collecting_rubbish_end_time = Gosu::milliseconds + 420
    update_state
  end

  def collect_nutrient(quiet=false)
    @sound_collect_nutrient.play unless quiet
  end

  def set_auto_move_to(x, y, &arrive_call_back)
    reset_durable_state
    @role.set_auto_move_to x, y, &arrive_call_back
  end

  def auto_move(area)
    @role.auto_move area
  end

  def update_eating_food
    @role.update_eating_food(*get_actual_role_location, scale_value)
  end

  def set_durable_state(state)
    return if state == Role::State::CAST # 投掷魔法球，暂不支持
    @role.durable_state = state
    update_state
    if state == Role::State::ROLL
      anim_goto_begin
    end
  end

  def reset_durable_state
    @role.durable_state = Role::State::STANDING
  end

  def set_state(state)
    @role.state = state
    change_anim
  end

  def update_state
    set_state get_state
  end

  def get_state
    if @role.battered
      if Gosu::milliseconds < @turn_to_battered_end_time
        return @hit_service.get_turn_to_battered_state(@role.battered_by_hit_type)
      end
      return @hit_service.get_battered_state(@role.battered_by_hit_type)
    end

    if @hitting
      return @hit_service.get_hitting_state(@hit_type)
    end

    if @collecting_rubbish
      return Role::State::COLLECTING_RUBBISH
    end

    if @role.eating?
      if @role.standing
        return Role::State::EATING
      else
        if driving?
          return Role::State::HOLDING_FOOD
        else
          return Role::State::HOLDING_FOOD
        end
      end
    else
      if @role.standing
        return @role.durable_state
      else
        if driving? && !wear_cloak?
          return Role::State::DRIVING
        else
          return @role.running ? Role::State::RUNNING : Role::State::WALKING
        end
      end
    end
  end

  def set_direction(direction)
    @role.direction = direction
  end

  def draw(auto_scale_info)
    draw_with_area_addition nil, auto_scale_info
  end

  def draw_with_area_addition(additional_equipment_vm, auto_scale_info)
    update_scale auto_scale_info, @role.y

    additional_equipment_vm.draw(*get_pure_role_feets_location, @role.direction) unless additional_equipment_vm.nil?

    should_draw_vehicle_first = driving_dragon? && @role.direction == Direction::UP

    draw_underpan

    draw_wing if @role.direction == Direction::DOWN # 临时方案
    draw_vehicle if should_draw_vehicle_first

    draw_handheld if @role.direction == Direction::UP

    draw_role_anim

    draw_eye_wear
    draw_hat
    draw_handheld unless @role.direction == Direction::UP

    draw_wing if @role.direction == Direction::UP
    draw_vehicle unless should_draw_vehicle_first
    draw_wing if @role.direction == Direction::LEFT || @role.direction == Direction::RIGHT

    draw_level_and_name
    @eating_food_vm.draw auto_scale_info unless @eating_food_vm.nil?
    draw_chat_bubble
  end

  def driving_dragon?
    driving? && @vehicle_vm.key.to_s.start_with?('dragon')
  end

  def add_chat_content(content)
    @chat_bubble_vm.add_content content
  end

  def update
    @update_times += 1
    if @update_times % 10 == 0
      @chat_bubble_vm.update_content
    end
    if @hitting
      @hitting = false if Gosu::milliseconds >= @hit_end_time
    end
    if @role.battered
      @role.battered = false if Gosu::milliseconds >= @battered_end_time
    end
    if @collecting_rubbish
      @collecting_rubbish = false if Gosu::milliseconds >= @collecting_rubbish_end_time
    end
  end

  def hit(sound=:hit)
    common_hit Role::State::HIT, true
    if sound == :hit
      @hit_service.play_hitting_sound(Role::State::HIT)
    elsif sound == :smash
      @sound_smash.play
    end
  end

  def common_hit(hit_type, quite=false)
    return unless @hit_service.is_hit? hit_type
    @hitting = true
    @hit_type = hit_type
    @hit_end_time = calc_end_time
    update_state
    anim_goto_begin
    unless quite
      @hit_service.play_hitting_sound(hit_type)
    end
  end

  def being_battered(hit_type)
    return unless @hit_service.is_hit? hit_type
    @role.battered = true
    @role.battered_by_hit_type = hit_type
    @turn_to_battered_end_time = Gosu::milliseconds +
        @hit_service.get_turn_to_battered_duration_time(hit_type)
    @battered_end_time = @turn_to_battered_end_time +
        @hit_service.get_battered_duration_time(hit_type)
    @hit_service.play_battered_sound hit_type
  end

  def try_miss
    miss = 0
    miss = @hat_vm.miss if !@hat_vm.nil? && !@hat_vm.miss.nil?
    miss = [miss, @vehicle_vm.miss].max if driving? && !@vehicle_vm.miss.nil?
    return false if miss == 0
    rand < miss
  end

  def get_actual_role_location
    x, y = get_pure_role_feets_location
    y = y - @vehicle_vm.height * scale_value if driving?
    y = y - @underpan_vm.height * scale_value unless @underpan_vm.nil?
    [x, y]
  end

  def get_pure_role_feets_location
    return @role.x, @role.y - 30 * scale_value
  end

  private

  def anim_goto_begin
    @anim_init_timestamp = Gosu::milliseconds
  end

  def calc_end_time
    Gosu::milliseconds + 585
  end

  def lv_image
    LevelUtil.image(@role.lv)
  end

  def change_anim
    state = @role.state.to_s
    direction = Direction::to_direction_text(@role.direction)
    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_anim(key)
    AnimationManager.get_anim key
    AnimationManager.get_anim key
  end

  def draw_role_anim
    x, y = get_actual_role_location
    @current_anim.draw(x, y, ZOrder::Player, init_timestamp:@anim_init_timestamp, scale_x:scale_value, scale_y:scale_value)
  end

  def draw_vehicle
    if driving?
      @vehicle_vm.draw(@role.x, @role.y - underpan_height, @role.direction, scale_value)
    end
  end

  def draw_underpan
    x, y = @role.x, @role.y
    @underpan_vm.draw(x, y - @underpan_vm.height, @role.direction, scale_value) unless @underpan_vm.nil?
  end

  def draw_eye_wear
    draw_equipment @eye_wear_vm
  end

  def draw_wing
    draw_equipment @wing_vm
  end

  def draw_hat
    draw_equipment @hat_vm
  end

  def draw_handheld
    draw_equipment @handheld_vm
  end

  def draw_equipment(equipment_vm)
    x, y = get_actual_role_location
    equipment_vm.draw(x, y, @role.direction, scale_value) unless equipment_vm.nil?
  end

  def draw_level_and_name
    name_width = @font.text_width(@role.name)
    lv_img_width = 15
    whole_width = lv_img_width + 2 + name_width
    level_left = @role.x - whole_width / 2
    level_height = @role.y + 14
    GraphicsUtil.draw_text_with_border(@role.name, @font, level_left + lv_img_width + 2, level_height,
                                       ZOrder::Player, 1, 1, 0xFF_EFE2DC, 0xFF_251B00)
    lv_image.draw(level_left, level_height, ZOrder::Player)
  end

  def draw_chat_bubble
    x, y = get_actual_role_location
    @chat_bubble_vm.draw_with_target x, y - 30
  end

  def underpan_height
    return 0 if @underpan_vm.nil?
    @underpan_vm.height
  end
end