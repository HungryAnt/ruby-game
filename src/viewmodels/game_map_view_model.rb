class GameMapViewModel
  attr_reader :package_items_view_model

  def initialize
    autowired(PlayerService, CommunicationService, MapService,
              GameRolesService, AreaItemsService, NetworkService,
              LargeRubbishesService)
    @sound_join_map = MediaUtil::get_sample('join_map.wav')
  end

  def init
    role = @player_service.role
    @player_view_model = PlayerViewModel.new(RoleViewModel.new(role))
    @mouse_vm = MouseViewModel.new
    init_roles
    init_area_items
    init_large_rubbishes
    @package_items_view_model = PackageItemsViewModel.new(@player_view_model)
    @update_times = 0
    @visual_items = []
  end

  def update
    @map_service.update_map

    map_vm = @map_service.current_map

    all_role_vms_do do |role_vm|
      role_vm.auto_move map_vm
      role_vm.update_eating_food
      role_vm.update_state
      role_vm.update
    end

    @player_view_model.update

    sort_visual_items if @update_times % 4 == 0

    goto_area
    @update_times += 1
  end

  def sort_visual_items
    @visual_items = []
    all_role_vms_do do |role_vm|
      @visual_items << role_vm
    end
    get_large_rubbish_vms.each do |large_rubbish_vm|
      @visual_items << large_rubbish_vm
    end
    @visual_items.sort_by! {|item| item.y}
  end

  def draw
    @map_service.draw_map
    # draw_role_vms
    get_item_vms.each { |item_vm| item_vm.draw }
    # get_large_rubbish_vms.each {|large_rubbish_vm| large_rubbish_vm.draw}
    @visual_items.each {|item| item.draw}
  end

  def draw_role_vms
    all_role_vms_do do |role_vm|
      role_vm.draw
    end
  end

  def draw_mouse(mouse_x, mouse_y)
    @mouse_vm.draw mouse_x, mouse_y
  end

  def all_role_vms_do
    area_id = @map_service.current_area.id
    @role_vm_dict.each_value do |role_vm|
      yield role_vm if role_vm.area_id == area_id
    end
    yield @player_view_model.role_vm
  end

  def player_move(direction)
    @player_view_model.move direction, @map_service::current_map
  end

  def update_mouse_type(mouse_x, mouse_y)
    map_vm = get_current_map
    mouse_left_down = Gosu::button_down?(Gosu::MsLeft)
    if map_vm.gateway? mouse_x, mouse_y
      @mouse_vm.set_mouse_type MouseType::GOTO_AREA
      return
    end

    if !@player_view_model.battered
      if touch_item?(mouse_x, mouse_y)
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::PICK_UP_BUTTON_DOWN : MouseType::PICK_UP)
        return
      end

      if touch_large_rubbish?(mouse_x, mouse_y)
        @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::SMASH_BUTTON_DOWN : MouseType::SMASH)
        return
      end
    end

    @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::NORMAL_BUTTON_DOWN : MouseType::NORMAL)
  end

  def switch_map(map_id)
    current_map = get_current_map
    return if !current_map.nil? && map_id == current_map.id.to_sym
    @map_service.switch_map map_id, @player_view_model.role
    @role_vm_dict.clear
    @player_view_model.switch_to_new_map
    @sound_join_map.play
  end

  def quit_map
    @map_service.quit_map
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

  def try_pick_up(mouse_x, mouse_y)
    return false if @player_view_model.battered

    item_vms = get_item_vms
    item_vm = get_touch_item mouse_x, mouse_y, item_vms
    return false if item_vm.nil?

    if item_vm.can_pick_up?(@player_view_model.role)
      @player_view_model.pick_up item_vms, item_vm
      return true
    end

    set_destination mouse_x, mouse_y, item_vm
    true
  end

  def try_smash_rubbish(mouse_x, mouse_y)
    return false if @player_view_model.battered
    large_rubbish_vm = get_touch_rubbish mouse_x, mouse_y
    return false if large_rubbish_vm.nil?
    if large_rubbish_vm.can_smash?(@player_view_model.role)
      @player_view_model.start_smash large_rubbish_vm
      return true
    end
    set_destination_for_smash large_rubbish_vm
    true
  end

  def stop_smash
    @player_view_model.stop_smash
  end

  def set_destination(mouse_x, mouse_y, item_vm = nil)
    map_vm = get_current_map
    unless map_vm.tile_block? mouse_x, mouse_y
      map_vm.mark_target(mouse_x, mouse_y) unless map_vm.nil?
      @player_view_model.set_destination mouse_x, mouse_y, item_vm
    end
  end

  def set_destination_for_smash(large_rubbish_vm)
    @player_view_model.set_destination_for_smash large_rubbish_vm
  end

  def discard
    @player_view_model.discard
  end

  def needs_cursor?
    @mouse_vm.needs_cursor?
  end

  def chat(msg)
    @communication_service.chat msg
  end

  def command(cmd)
    user_id = @player_service.user_id
    @communication_service.command cmd.chomp('`'), user_id, get_current_map.id, get_current_area.id.to_s
  end

  def change_driving
    @player_view_model.set_driving(!@player_view_model.driving)
  end

  def hit
    @player_view_model.hit
  end

  private

  def init_roles
    @role_vm_dict = {}
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

  def register_role_msg_call_back
    @game_roles_service.register_role_msg_call_back do |role_msg|
      if is_in_chat_map
        user_id = role_msg.user_id

        if @player_service.user_id != user_id
          role_map = role_msg.role_map
          role_type = role_map['role_type'].to_sym
          role_vm = get_role_vm user_id, role_map['name'], role_type

          role_vm.role.x = role_map['x'].to_i
          role_vm.role.y = role_map['y'].to_i
          role_vm.role.hp = role_map['hp'].to_i
          role_vm.role.update_lv(role_map['lv'].to_i, 0)
          role_vm.set_state role_map['state'].to_sym
          role_vm.set_direction role_map['direction'].to_i
          role_vm.area_id = role_map['area_id'].to_sym
          if role_map['vehicle'].nil?
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
    @game_roles_service.register_delete_role_call_back do |user_id|
      role_vm = @role_vm_dict[user_id]
      role_vm.area_id = :none unless role_vm.nil?
    end
  end

  def register_eating_food_call_back
    @game_roles_service.register_eating_food_call_back do |user_id, food_type_id|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          role_vm_eat_food role_vm, food_type_id unless role_vm.nil?
        end
      end
    end
  end

  def register_eat_up_food_call_back
    @game_roles_service.register_eat_up_food_call_back do |user_id|
      if @player_service.user_id != user_id
        role_vm = @role_vm_dict[user_id]
        role_vm.clear_food unless role_vm.nil?
      end
    end
  end

  def register_chat_call_back
    @game_roles_service.register_chat_call_back do |user_id, user_name, content|
      if @player_service.user_id == user_id
        role_vm = @player_view_model.role_vm
      else
        role_vm =  @role_vm_dict[user_id]
      end
      role_vm.add_chat_content content unless role_vm.nil?
    end
  end

  def register_hit_call_back
    @game_roles_service.register_hit_call_back do |user_id, area_id, target_x, target_y|
      if is_in_chat_map
        if @player_service.user_id != user_id && is_current_area(area_id)
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.hit
            @player_view_model.check_hit_battered(target_x, target_y)
          end
        end
      end
    end
  end

  def register_being_battered_call_back
    @game_roles_service.register_being_battered_call_back do |user_id|
      if is_in_chat_map
        if @player_service.user_id != user_id
          role_vm = @role_vm_dict[user_id]
          if !role_vm.nil? && is_current_area(role_vm.area_id)
            role_vm.being_battered
          end
        end
      end
    end
  end

  def register_collecting_rubbish_call_back
    @game_roles_service.register_collecting_rubbish_call_back do |user_id|
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
    @game_roles_service.register_collecting_nutrient_call_back do |user_id|
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
    @game_roles_service.register_smash_callback do |user_id, area_id|
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

  def init_area_items
    @area_items_service.register_item_msg_callback do |area_item_msg|
      area_id = area_item_msg.area_id
      item_map = area_item_msg.item_map
      area_vm = @map_service.get_area(area_id)
      case area_item_msg.action
        when AreaItemMessage::Action::CREATE
          area_vm.add_item_vm ItemViewModelFactory.create_item_vm(item_map)
        when AreaItemMessage::Action::DELETE
          area_vm.delete_item_vm item_map['id']
        when AreaItemMessage::Action::PICKUP
          item_vm = ItemViewModelFactory.create_item_vm(item_map)
          item_vm.pick_up(@player_view_model)
      end
    end
  end

  def init_large_rubbishes
    @large_rubbishes_service.register_large_rubbish_msg_callback do |large_rubbish_msg|
      area_id = large_rubbish_msg.area_id
      item_map = large_rubbish_msg.item_map
      area_vm = @map_service.get_area(area_id)
      case large_rubbish_msg.action
        when LargeRubbishMessage::Action::CREATE
          area_vm.add_large_rubbish_vm LargeRubbishViewModelFactory.create_large_rubbish_vm(item_map)
        when LargeRubbishMessage::Action::UPDATE
          area_vm.update_large_rubbish_vm LargeRubbishViewModelFactory.create_large_rubbish_vm(item_map)
        when LargeRubbishMessage::Action::DESTROY
          large_rubbish_id = item_map['id']
          area_vm.destroy_large_rubbish_vm large_rubbish_id
          @player_view_model.stop_smash_large_rubbish large_rubbish_id
      end
    end
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

  def get_current_map
    @map_service.current_map
  end

  def get_current_area
    get_current_map.current_area
  end

  def is_current_area(area_id)
    map = get_current_map
    return false if map.nil?
    area_id == map.current_area.id
  end

  def is_in_chat_map
    !get_current_map.nil?
  end

  def touch_item?(mouse_x, mouse_y)
    item_vm = get_touch_item(mouse_x, mouse_y, get_item_vms)
    !item_vm.nil?
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

  def get_item_vms
    @map_service.current_map.current_area.get_item_vms
  end

  def get_touch_item(mouse_x, mouse_y, item_vms)
    item_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(mouse_x, mouse_y)
    end
    nil
  end

  def touch_large_rubbish?(mouse_x, mouse_y)
    item_vm = get_touch_rubbish(mouse_x, mouse_y)
    !item_vm.nil?
  end

  def get_large_rubbish_vms
    @map_service.current_map.current_area.get_large_rubbish_vms
  end

  def get_touch_rubbish(mouse_x, mouse_y)
    get_large_rubbish_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(mouse_x, mouse_y)
    end
    nil
  end
end