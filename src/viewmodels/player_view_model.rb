require_relative 'role_view_model'

class PlayerViewModel
  attr_reader :role, :role_vm

  HIT_COST_HP = 8
  BEING_BATTERED_COST_HP = 45

  def initialize(role_vm)
    autowired(PlayerService, MapService, CommunicationService, HitService)
    @role_vm = role_vm
    @role = @role_vm.role
    @move_timestamp = Gosu::milliseconds
    @update_times = 0
    @sound_run = MediaUtil.get_sample 'run.wav'
    @smash_beging_update_time = 0
    @smashing_large_rubbish_vm = nil
  end

  def update
    have_a_rest if @role.standing
    eat if @role.standing
    refresh_exp if @update_times % GameConfig::FPS == 0
    smash if @update_times % GameConfig::FPS == @smash_beging_update_time
    @update_times += 1
  end

  def refresh_exp
    exp = @role.query_and_dec_temp_exp
    remote_inc_exp(exp) if exp > 0
  end

  def draw
    @role_vm.draw
  end

  def driving
    @role_vm.driving
  end

  def set_driving(value)
    @role_vm.set_driving value
    sync_role_appear
  end

  def equip(equipment_vm)
    @role_vm.vehicle_vm = equipment_vm
  end

  def pick_up(item_vms, item_vm)
    return if battered
    return unless item_vms.include? item_vm

    # 先尝试扔掉正在吃的食物
    discard
    item = item_vm.item
    try_remote_pickup_item item
  end

  def discard
    item = @role.discard
    return if item.nil?
    if item.respond_to? :eatable?
      eat_up
      remote_discard_item item
    end
  end

  def set_destination(x, y, item_vm)
    @role_vm.set_auto_move_to(x, y) {
      item_vms = @map_service.current_map.current_area.item_vms
      pick_up(item_vms, item_vm) unless item_vm.nil?
      sync_role_appear
    }
    set_destination_with_target x, y
  end

  def set_destination_for_smash(large_rubbish_vm)
    x, y = large_rubbish_vm.get_destination @role
    @role_vm.set_auto_move_to(x, y) {
      sync_role_appear
      start_smash(large_rubbish_vm) unless large_rubbish_vm.nil?
    }
    set_destination_with_target x, y
  end

  def set_destination_with_target(x, y)
    detail = {
        target_x:x,
        target_y:y
    }
    sync_role Role::Action::AUTO_MOVE_TO, detail
    if @role.hp > 0
      @sound_run.play
    end
  end

  def update_animations
    @role_vm.init_animations
    @role_vm.update_state
  end

  def appear_in_new_area
    @role_vm.appear_in_new_area
    stop_smash
    sync_role_appear
  end

  def switch_to_new_map
    map_vm = @map_service.current_map
    @role.x, @role.y = map_vm.current_area.area.initial_position
    refresh_new_map_elements map_vm.id
    appear_in_new_area
  end

  def start_eat_food(food_vm)
    @role_vm.eat_food food_vm
    remote_eating_food food_vm.food
  end

  def collect_rubbish(rubbish_vm)
    @role_vm.collect_rubbish
    @role.rubbish_bin.inc rubbish_vm.rubbish_type_id
    remote_collect_rubbish rubbish_vm.rubbish
  end

  def collect_nutrient(nutrient_vm)
    @role_vm.collect_nutrient
    @role.nutrient_bin.inc nutrient_vm.nutrient_type_id
    remote_collect_nutrient nutrient_vm.nutrient
  end

  def hit
    hit_range = 70
    do_hit :hit, HIT_COST_HP, hit_range
  end

  def finger_hit
    hit_cost = 4
    hit_range = 50
    do_hit :finger_hit, hit_cost, hit_range
  end

  def fart
    hit_cost = 4
    hit_range = -50
    do_hit :fart, hit_cost, hit_range
  end

  def head_hit
    hit_cost = 4
    hit_range = 50
    do_hit :head_hit, hit_cost, hit_range
  end

  def do_hit(hit_type, cost_hp, hit_range)
    return if @role_vm.hitting || battered || @role.eating?
    @role_vm.disable_auto_move
    sync_role_appear
    return if @role.hp < cost_hp
    @role.dec_hp(cost_hp)
    @role_vm.common_hit hit_type
    target_x, target_y = get_hit_target hit_range
    remote_hit get_user_id, get_current_area_id, hit_type, target_x, target_y
  end

  def get_hit_target(hit_range)
    return @role.x - hit_range, @role.y if Direction.is_direct_to_left(@role.direction)
    return @role.x + hit_range, @role.y if Direction.is_direct_to_right(@role.direction)
    return @role.x, @role.y - hit_range/2.5 if Direction.is_direct_to_up(@role.direction)
    return @role.x, @role.y + hit_range/2.5 if Direction.is_direct_to_down(@role.direction)
  end

  def check_hit_battered(hit_type, hit_x, hit_y)
    return unless @hit_service.is_hit? hit_type
    return if battered
    return if @role_vm.driving_dragon?
    if Gosu::distance(@role.x, @role.y, hit_x, hit_y) < 28
      discard
      battered_cost_hp = @hit_service.get_battered_cost_hp hit_type
      @role.dec_hp(battered_cost_hp)
      @role_vm.being_battered hit_type
      remote_being_battered get_user_id, hit_type
    end
  end

  def battered
    @role.battered
  end

  def start_smash(large_rubbish_vm)
    discard
    # @smash_beging_update_time = @update_times % GameConfig::FPS
    @smashing_large_rubbish_vm = large_rubbish_vm
  end

  def stop_smash
    @smashing_large_rubbish_vm = nil
  end

  def stop_smash_large_rubbish(large_rubbish_id)
    stop_smash if smashing? && @smashing_large_rubbish_vm.id == large_rubbish_id
  end

  def smashing?
    !@smashing_large_rubbish_vm.nil?
  end

  def smash
    return if !smashing?
    return if @role_vm.hitting || battered || @role.eating?
    large_rubbish_vm = @smashing_large_rubbish_vm
    @role_vm.disable_auto_move
    sync_role_appear
    @role_vm.adjust_to_suit_direction(large_rubbish_vm.x, large_rubbish_vm.y)
    @role_vm.hit(:smash)
    remote_smash large_rubbish_vm.id
    # large_rubbish_vm.smash
  end

  def set_action(action)
    if action == Role::State::HIT
      hit
      return
    end
    if action == Role::State::FINGER_HIT
      finger_hit
      return
    end
    if action == Role::State::FART
      fart
      return
    end
    if action == Role::State::HEAD_HIT
      head_hit
      return
    end
    return if @role_vm.hitting || battered
    discard
    @role_vm.set_durable_state action
    sync_role_appear
  end

  private

  def eat
    if @role.eating?
      @role.eat
      eat_up unless @role.eating?
    end
  end

  def eat_up
    @role_vm.clear_food
    remote_eat_up_food
    # remote_update_lv
  end

  def have_a_rest
    @role.inc_hp(GameConfig::REST_HP_INC)
  end

  def sync_role_appear
    sync_role Role::Action::APPEAR, {}
  end

  def sync_role(action, detail)
    area_id = get_current_area_id
    role_map = @role.to_map
    role_map['area_id'] = area_id
    role_map['action'] = action.to_s
    role_map['detail'] = detail
    @communication_service.send_role_message role_map
  end

  def refresh_new_map_elements(map_id)
    map_vm = @map_service.current_map
    map_vm.clear_items

    @communication_service.send_roles_query_message map_id
    @communication_service.send_area_items_query_message map_id
    @communication_service.send_area_large_rubbishes_query_message map_id
  end

  def remote_discard_item(item)
    area_id = get_current_area_id
    @communication_service.send_discard_item_message area_id, item.to_map
  end

  def try_remote_pickup_item(item)
    area_id = get_current_area_id
    user_id = get_user_id
    @communication_service.send_try_pickup_item_message(user_id, area_id, item.id)
  end

  def remote_eating_food(food)
    user_id = get_user_id
    @communication_service.send_eating_food_message(user_id, food.to_food_map)
  end

  def remote_eat_up_food
    user_id = get_user_id
    @communication_service.send_eat_up_food_message(user_id)
  end

  # def remote_update_lv
  #   @communication_service.send_update_lv get_user_id, @role.lv, @role.exp
  # end

  def remote_inc_exp(exp)
    @communication_service.send_inc_exp_message get_user_id, exp
  end

  def remote_hit(user_id, area_id, hit_type, target_x, target_y)
    @communication_service.send_hit_message user_id, area_id, hit_type, target_x, target_y
  end

  def remote_being_battered(user_id, hit_type)
    @communication_service.send_being_battered_message user_id, hit_type
  end

  def remote_collect_rubbish(rubbish)
    user_id = get_user_id
    @communication_service.send_collect_rubbish_message(user_id, rubbish.to_rubbish_map)
  end

  def remote_collect_nutrient(nutrient)
    user_id = get_user_id
    @communication_service.send_collect_nutrient_message(user_id, nutrient.to_nutrient_map)
  end

  def remote_smash(large_rubbish_id)
    user_id = get_user_id
    area_id = get_current_area_id
    @communication_service.send_smash_large_rubbish_message(user_id, area_id, large_rubbish_id)
  end

  def get_current_area_id
    @map_service.current_map.current_area.id.to_s
  end

  def get_user_id
    @player_service.user_id
  end
end