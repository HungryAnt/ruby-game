module GameRole

  def chat(msg)
    @communication_service.chat msg
  end

  def try_pick_up(mouse_x, mouse_y)
    return false if @player_view_model.battered
    actual_x, actual_y = to_area_actual_location mouse_x, mouse_y

    item_vms = get_item_vms
    item_vm = get_touch_item actual_x, actual_y, item_vms
    return false if item_vm.nil?

    if item_vm.can_pick_up?(@player_view_model.role)
      @player_view_model.pick_up item_vms, item_vm
      return true
    end

    set_destination mouse_x, mouse_y, item_vm
    true
  end

  def try_smash_enemy(mouse_x, mouse_y)
    return false if @player_view_model.battered
    actual_x, actual_y = to_area_actual_location mouse_x, mouse_y

    enemy_vm = get_touch_enemy actual_x, actual_y
    return false if enemy_vm.nil?
    if enemy_vm.can_smash?(@player_view_model.role)
      @player_view_model.start_smash enemy_vm
      return true
    end
    set_destination_for_smash enemy_vm
    true
  end

  def get_touch_enemy(actual_x, actual_y)
    monster_vm = get_touch_monster actual_x, actual_y
    return monster_vm unless monster_vm.nil?
    get_touch_rubbish actual_x, actual_y
  end

  def stop_smash
    @player_view_model.stop_smash
  end

  def set_destination(mouse_x, mouse_y, item_vm = nil)
    actual_x, actual_y = to_area_actual_location mouse_x, mouse_y
    map_vm = get_current_map
    unless map_vm.tile_block? actual_x, actual_y
      map_vm.mark_target(mouse_x, mouse_y) unless map_vm.nil?
      @player_view_model.set_destination actual_x, actual_y, item_vm
    end
  end

  def set_destination_for_smash(enemy_vm)
    @player_view_model.set_destination_for_smash enemy_vm
  end

  def discard
    @player_view_model.discard
  end

  def switch_to_next_role_type
    current_role_type = @player_view_model.role.role_type
    @player_view_model.role.role_type = RoleType::next(current_role_type)
    @player_view_model.update_animations
  end

  def switch_to_prev_role_type
    current_role_type = @player_view_model.role.role_type
    @player_view_model.role.role_type = RoleType::prev(current_role_type)
    @player_view_model.update_animations
  end

  def change_driving
    @player_view_model.set_driving(!@player_view_model.driving)
  end

  def hit
    @player_view_model.hit
  end

  def set_player_action(action)
    @player_view_model.set_action action
  end

  def player_cast
    @player_view_model.cast
  end

  private

  def process_role_vms
    area_id = get_current_area.id
    @role_vm_dict.each_value do |role_vm|
      yield role_vm if role_vm.area_id == area_id
    end
    yield @player_view_model.role_vm
  end

  def init_roles
    role = @player_service.role
    @player_view_model = PlayerViewModel.new(RoleViewModel.new(role))
    @role_vm_dict = {}
    register_update_lv_callback
    register_role_msg_call_back
    register_delete_role_call_back
    register_eating_food_call_back
    register_eat_up_food_call_back
    register_chat_call_back
    register_hit_call_back
    register_being_battered_call_back
    register_collecting_rubbish_call_back
    register_collecting_nutrient_call_back
    register_smash_callback
  end

  def goto_area
    map_vm = get_current_map
    role = @player_view_model.role
    if map_vm.gateway? role.x, role.y
      # @player_view_model.disappear
      map_vm.goto_area role
      @player_view_model.appear_in_new_area
      return true
    end
    false
  end

  def get_role_vm(user_id, user_name, role_type)
    role_vm = @role_vm_dict[user_id]
    if role_vm.nil?
      role = Role.new(user_name, role_type, 100, 300)
      role_vm = RoleViewModel.new(role)
      @role_vm_dict[user_id] = role_vm
    end
    role_vm
  end

  def register_update_lv_callback
    @user_service.register_update_lv_callback do |lv, exp|
      @player_view_model.role.update_lv lv, exp
    end
  end

  def register_role_msg_call_back
    @game_roles_communication_handler.register_role_msg_call_back do |role_msg|
      if is_in_chat_map
        user_id = role_msg.user_id

        if @player_service.user_id != user_id
          role_map = role_msg.role_map
          role_type = role_map['role_type'].to_sym
          role_vm = get_role_vm user_id, role_map['name'], role_type

          role_vm.area_id = role_map['area_id'].to_sym
          role_vm.role.x = role_map['x'].to_i
          role_vm.role.y = role_map['y'].to_i
          role_vm.role.hp = role_map['hp'].to_i
          role_vm.role.update_lv(role_map['lv'].to_i, 0)
          role_vm.set_state role_map['state'].to_sym
          role_vm.set_durable_state role_map['durable_state'].to_sym
          role_vm.set_direction role_map['direction'].to_i

          if role_map['vehicle'].nil? || role_map['vehicle'].length == 0
            vehicle_key = nil
          else
            vehicle_key = role_map['vehicle'].to_sym
          end
          role_vm.drive(vehicle_key)

          action = role_map['action'].to_sym
          detail = role_map['detail']
          case action
            when Role::Action::APPEAR
              role_vm.appear_in_new_area
            when Role::Action::AUTO_MOVE_TO
              target_x = detail['target_x'].to_i
              target_y = detail['target_y'].to_i
              role_vm.set_auto_move_to(target_x, target_y)
          end

          food_type_id = role_map['food_type_id']
          unless food_type_id.nil?
            if food_type_id >= 0
              role_vm_eat_food role_vm, food_type_id, true
            else
              role_vm.clear_food
            end
          end
        end
      end # is_in_chat_map
    end
  end

  def register_delete_role_call_back
    @game_roles_communication_handler.register_delete_role_call_back do |user_id|
      role_vm = @role_vm_dict[user_id]
      role_vm.area_id = :none unless role_vm.nil?
    end
  end

  def register_eating_food_call_back
    @game_roles_communication_handler.register_eating_food_call_back do |user_id, food_type_id|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          role_vm_eat_food role_vm, food_type_id unless role_vm.nil?
        end
      end
    end
  end

  def register_eat_up_food_call_back
    @game_roles_communication_handler.register_eat_up_food_call_back do |user_id|
      if @player_service.user_id != user_id
        role_vm = @role_vm_dict[user_id]
        role_vm.clear_food unless role_vm.nil?
      end
    end
  end

  def register_chat_call_back
    @game_roles_communication_handler.register_chat_call_back do |user_id, user_name, content|
      if @player_service.user_id == user_id
        role_vm = @player_view_model.role_vm
      else
        role_vm =  @role_vm_dict[user_id]
      end
      role_vm.add_chat_content content unless role_vm.nil?
    end
  end

  def register_hit_call_back
    @game_roles_communication_handler.register_hit_call_back do |user_id, area_id, hit_type, target_x, target_y|
      if is_in_chat_map
        if @player_service.user_id != user_id && is_current_area(area_id)
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.common_hit hit_type
            @player_view_model.check_hit_battered(hit_type, target_x, target_y)
          end
        end
      end
    end
  end

  def register_being_battered_call_back
    @game_roles_communication_handler.register_being_battered_call_back do |user_id, hit_type|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.being_battered hit_type
          end
        end
      end
    end
  end

  def register_collecting_rubbish_call_back
    @game_roles_communication_handler.register_collecting_rubbish_call_back do |user_id|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.collect_rubbish
          end
        end
      end
    end
  end

  def register_collecting_nutrient_call_back
    @game_roles_communication_handler.register_collecting_nutrient_call_back do |user_id|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.collect_nutrient
          end
        end
      end
    end
  end

  def register_smash_callback
    @game_roles_communication_handler.register_smash_callback do |user_id, area_id|
      call_role_vm(user_id, area_id) {|role_vm| role_vm.hit(:smash)}
    end
  end

  def call_role_vm(user_id, area_id)
    if is_in_chat_map
      if @player_service.user_id != user_id && is_current_area(area_id)
        role_vm = @role_vm_dict[user_id]
        if !role_vm.nil? && is_current_area(role_vm.area_id)
          yield role_vm
        end
      end
    end
  end

  def role_vm_eat_food(role_vm, food_type_id, quietly = false)
    food_vm = ItemViewModelFactory.create_simple_food_vm(food_type_id)
    if quietly || role_vm.area_id != get_current_area.id
      role_vm.eat_food_quietly food_vm
    else
      role_vm.eat_food food_vm
    end
  end
end