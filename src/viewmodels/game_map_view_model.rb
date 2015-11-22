class GameMapViewModel
  attr_reader :package_items_view_model

  def initialize
    autowired(PlayerService, CommunicationService, MapService,
              GameRolesCommunicationHandler, PetCommunicationHandler,
              AreaItemsService, NetworkService,
              LargeRubbishesService, UserService)
    @sound_join_map = MediaUtil::get_sample('join_map.wav')
  end

  def init
    role = @player_service.role
    @player_view_model = PlayerViewModel.new(RoleViewModel.new(role))
    @mouse_vm = MouseViewModel.new
    init_roles
    init_pets
    init_area_items
    init_large_rubbishes
    @package_items_view_model = PackageItemsViewModel.new(@player_view_model)
    @update_times = 0
    @visual_items = []
  end

  def update
    @map_service.update_map

    area = get_current_area.area

    process_role_vms do |role_vm|
      role_vm.auto_move area
      role_vm.update_eating_food
      role_vm.update_state
      role_vm.update
    end

    @player_view_model.update area

    process_other_pet_vms do |pet_vm|
      pet_vm.update area
    end

    sort_visual_items

    goto_area
    @update_times += 1
  end

  def sort_visual_items
    @visual_items = []
    process_role_vms do |role_vm|
      @visual_items << role_vm
    end
    get_large_rubbish_vms.each do |large_rubbish_vm|
      @visual_items << large_rubbish_vm
    end
    get_current_area.visual_element_vms.each do |element_vm|
      @visual_items << element_vm
    end
    @player_view_model.pets_vms.each { |pet_vm| @visual_items << pet_vm }

    @pet_vm_dict.each_value { |pet_vm| @visual_items << pet_vm }

    @visual_items.sort_by! {|item| item.y}
  end

  def draw
    @map_service.draw_map
    get_item_vms.each { |item_vm| item_vm.draw }
    @visual_items.each {|item| item.draw}
  end

  def draw_mouse(mouse_x, mouse_y)
    @mouse_vm.draw mouse_x, mouse_y
  end

  def process_role_vms
    area_id = get_current_area.id
    @role_vm_dict.each_value do |role_vm|
      yield role_vm if role_vm.area_id == area_id
    end
    yield @player_view_model.role_vm
  end

  def process_other_pet_vms
    area_id = get_current_area.id
    @pet_vm_dict.each_value do |pet_vm|
      yield pet_vm if pet_vm.area_id == area_id
    end
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

  def set_player_action(action)
    @player_view_model.set_action action
  end

  def pet_move_to(x, y)
    return if @player_view_model.pets_vms.count == 0
    map_vm = get_current_map
    unless map_vm.tile_block? x, y
      map_vm.mark_target(x, y) unless map_vm.nil?
      @player_view_model.pet_move_to x, y
    end
  end

  def take_pets
    @player_view_model.take_pets
  end

  private

  def init_roles
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

  def init_pets
    @pet_vm_dict = {}
    register_update_pet_callback
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

  def register_update_pet_callback
    @pet_communication_handler.register_update_pet_callback do |pet_msg|
      if is_in_chat_map
        pet_id = pet_msg.pet_id
        destination = pet_msg.destination
        if !@player_view_model.contains_pet_id?(pet_id)
          update_pet pet_msg.area_id.to_sym, pet_msg.pet_id, pet_msg.pet_type.to_sym,
                     pet_msg.pet_map, destination
        end
      end
    end
  end

  def update_pet(area_id, pet_id, pet_type, pet_map, destination)
    pet_vm = get_pet_vm(pet_id, pet_type)

    pet_vm.area_id = area_id
    pet_vm.pet.x = pet_map['x'].to_i
    pet_vm.pet.y = pet_map['y'].to_i
    pet_vm.pet.state = pet_map['state'].to_sym
    pet_vm.pet.durable_state = pet_map['durable_state'].to_sym
    pet_vm.pet.direction = pet_map['direction']

    if destination.size > 0
      pet_vm.move_to destination['x'].to_i, destination['y'].to_i
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

  def get_pet_vm(pet_id, pet_type)
    pet_vm = @pet_vm_dict[pet_id]
    if pet_vm.nil?
      pet = Pet.new(pet_id, pet_type, 110, 310)
      pet_vm = PetViewModel.new(pet)
      @pet_vm_dict[pet_id] = pet_vm
    end
    pet_vm
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