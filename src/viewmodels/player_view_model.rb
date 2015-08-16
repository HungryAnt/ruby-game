require_relative 'role_view_model'

class PlayerViewModel
  attr_reader :role, :role_vm

  def initialize(role_vm)
    autowired(MapService, ChatService)
    @role_vm = role_vm
    @role = @role_vm.role
    @move_timestamp = Gosu::milliseconds
    @update_times = 0
  end

  def update
    have_a_rest if @role_vm.standing
    eat if @role_vm.standing
    @role.refresh_exp if @update_times % 40 == 0
    @update_times += 1
  end

  def draw
    @role_vm.draw
  end

  def move(direction, map_vm)
    if direction != Direction::NONE
      @auto_move_enabled = false
      @role.direction = direction
      angle = Direction::to_angle direction
      @role_vm.control_move(angle, map_vm)
    else
      @role_vm.stop
    end
  end

  def pick_up(item_vms, item_vm)
    return unless item_vms.include? item_vm

    # 先尝试扔掉正在吃的食物
    discard item_vms

    item_vms.reject! { |item| item == item_vm }
    item = item_vm.item

    if item.respond_to? :eatable?
      start_eat_food item
    end
  end

  def discard(food_vms)
    item = @role.discard
    return if item.nil?
    if item.respond_to? :eatable?
      food_vm = FoodViewModel.new item
      food_vms << food_vm
    end
  end

  def set_destination(x, y, item_vm)
    @role_vm.set_auto_move_to(x, y) {
      item_vms = @map_service.current_map.current_area.item_vms
      pick_up(item_vms, item_vm) unless item_vm.nil?
      sync_role Role::Action::APPEAR, {}
    }
    detail = {
        target_x:x,
        target_y:y
    }
    sync_role Role::Action::AUTO_MOVE_TO, detail
  end

  def update_animations
    @role_vm.init_animations
    @role_vm.update_state
  end

  def appear_in_new_area
    @role_vm.appear_in_new_area
    detail = {}
    sync_role Role::Action::APPEAR, detail
  end

  def switch_to_new_map
    map_vm = @map_service.current_map
    @role.x, @role.y = map_vm.current_area.area.initial_position
    query_roles map_vm.id
    appear_in_new_area
  end

  def disappear
    # detail = {}
    # sync_role Role::Action::DISAPPEAR, detail
  end

  private

  def start_eat_food(food)
    @role_vm.eat_food food
  end

  def eat
    @role.eat
    @role_vm.clear_food unless @role.eating?
  end

  def have_a_rest
    @role.inc_hp(GameConfig::REST_HP_INC)
  end

  def sync_role(action, detail)
    area_id = @map_service.current_map.current_area.id.to_s
    role_map = @role.to_map
    role_map['area_id'] = area_id
    role_map['action'] = action.to_s
    role_map['detail'] = detail
    @chat_service.send_role_message role_map
  end

  def query_roles(map_id)
    @chat_service.send_roles_query_message map_id
  end
end