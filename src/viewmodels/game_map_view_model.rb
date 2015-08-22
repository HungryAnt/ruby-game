class GameMapViewModel
  def initialize
    autowired(PlayerService, ChatService, MapService,
              GameRolesService, AreaItemsService, NetworkService)
  end

  def init
    role = @player_service.role
    @player_view_model = PlayerViewModel.new(RoleViewModel.new(role))
    @gen_food_timestamp = Gosu::milliseconds
    @map_service.switch_map :grass_wood_back, role
    @mouse_vm = MouseViewModel.new
    init_roles
    init_area_items
    # @player_view_model.switch_to_new_map
  end

  def update
    @map_service.update_map

    # seconds = (Gosu::milliseconds - @gen_food_timestamp) / 1000
    # if seconds > 0
    #   @gen_food_timestamp += seconds * 1000
    #   0.upto(seconds - 1).each do
    #     area_id = @map_service.current_map.current_area.id.to_s
    #     food = FoodFactory.random_food(*@map_service::current_map.random_available_position)
    #     item_map = food.to_map
    #     area_item_msg = AreaItemMessage.new(area_id, item_map)
    #     add_area_item area_item_msg
    #   end
    # end

    if @network_service.has_error?
      seconds = (Gosu::milliseconds - @gen_food_timestamp) / 1000
      gen_count = (seconds * GameConfig::FOOD_GEN_PER_SECOND).to_i
      if gen_count > 0
        @gen_food_timestamp += seconds * 1000

        food_vms = get_food_vms
        if food_vms.size < 5
          0.upto(gen_count - 1).each do
            food = FoodFactory.random_food(*@map_service::current_map.random_available_position)
            food_vms << FoodViewModel.new(food)
          end
        end
      end
    end

    map_vm = @map_service.current_map

    all_role_vms_do do |role_vm|
      role_vm.auto_move map_vm
      role_vm.role.update_eating_food
      role_vm.update_state
    end

    @player_view_model.update

    goto_area
  end

  def draw
    @map_service.draw_map
    draw_role_vms
    get_food_vms.each { |food_vm| food_vm.draw }
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
    elsif touch_item? mouse_x, mouse_y
      @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::PICK_UP_BUTTON_DOWN : MouseType::PICK_UP)
    else
      @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::NORMAL_BUTTON_DOWN : MouseType::NORMAL)
    end
  end

  def switch_map(map_id)
    return if map_id == get_current_map.id.to_sym
    @player_view_model.disappear
    @map_service.switch_map map_id, @player_view_model.role
    @role_vm_dict.clear
    @player_view_model.switch_to_new_map
  end

  def switch_role_type(role_type)
    @player_view_model.role.role_type = role_type
    @player_view_model.update_animations
  end

  def try_pick_up(mouse_x, mouse_y)
    item_vms = get_food_vms
    item_vm = get_touch_item mouse_x, mouse_y, item_vms
    return false if item_vm.nil?

    if item_vm.can_pick_up?(@player_view_model.role)
      @player_view_model.pick_up item_vms, item_vm
      true
    end

    set_destination mouse_x, mouse_y, item_vm
    true
  end

  def set_destination(mouse_x, mouse_y, item_vm = nil)
    map_vm = get_current_map
    unless map_vm.tile_block? mouse_x, mouse_y
      map_vm.mark_target(mouse_x, mouse_y) unless map_vm.nil?
      @player_view_model.set_destination mouse_x, mouse_y, item_vm
    end
  end

  def discard
    @player_view_model.discard
  end

  def needs_cursor?
    @mouse_vm.needs_cursor?
  end

  def chat(msg)
    @chat_service.chat msg
  end

  private

  def init_roles
    @role_vm_dict = {}
    register_role_msg_call_back
    register_delete_role_call_back
    register_eating_food_call_back
    register_eat_up_food_call_back
  end

  def register_role_msg_call_back
    @game_roles_service.register_role_msg_call_back do |role_msg|
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
    end
  end

  def register_delete_role_call_back
    @game_roles_service.register_delete_role_call_back do |user_id|
      role_vm = @role_vm_dict[user_id]
      role_vm.area_id = :none
    end
  end

  def register_eating_food_call_back
    @game_roles_service.register_eating_food_call_back do |user_id, food_type_id|
      if @player_service.user_id != user_id
        role_vm = @role_vm_dict[user_id]
        role_vm_eat_food role_vm, food_type_id unless role_vm.nil?
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
          food_vm = ItemViewModelFactory.create_item_vm(item_map)
          @player_view_model.start_eat_food(food_vm)
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

  def touch_item?(mouse_x, mouse_y)
    item_vm = get_touch_item(mouse_x, mouse_y, get_food_vms)
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

  def get_food_vms
    @map_service.current_map.current_area.get_item_vms
  end

  def get_touch_item(mouse_x, mouse_y, food_vms)
    food_vms.each do |food_vm|
      return food_vm if food_vm.mouse_touch?(mouse_x, mouse_y)
    end
    nil
  end
end