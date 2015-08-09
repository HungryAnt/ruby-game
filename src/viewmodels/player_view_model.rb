require_relative 'role_view_model'

class PlayerViewModel < RoleViewModel
  def initialize(role)
    super role
    @speed = 2.0
    @move_timestamp = Gosu::milliseconds
    @standing = true
    @running = true
    @update_times = 0
    @auto_move_enabled = false
  end

  def update
    map_vm = @map_service.current_map
    auto_move map_vm
    @role.update_eating_food
    have_a_rest if @standing
    change_state
    change_anim
    eat if @standing
    @role.refresh_exp if @update_times % 40 == 0
    @update_times += 1
  end


  def move(direction, map_vm)
    if direction != Direction::NONE
      @auto_move_enabled = false
      @role.direction = direction
      angle = Direction::to_angle direction
      do_move(angle, map_vm)
    else
      @standing = true
    end
  end

  def pick_up(item_vms, item_vm)
    return unless item_vms.include? item_vm

    # 先尝试扔掉正在吃的食物
    discard item_vms

    item_vms.reject! { |item| item == item_vm }
    item = item_vm.item
    @beep.play
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
    @auto_move_enabled = true
    @auto_move_angle = Gosu::angle(@role.x, @role.y, x, y)
    @auto_move_dest = {:x => x, :y => y}
    @auto_pick_up_item = item_vm
  end

  def disable_auto_move
    @auto_move_enabled = false
  end

  def update_animations
    init_animations
    change_state
  end

  private

  def change_state
    if @role.eating?
      if @standing
        @role.state = Role::State::EATING
      else
        @role.state = Role::State::HOLDING_FOOD
      end
    else
      if @standing
        @role.state = Role::State::STANDING
      else
        @role.state = @running ? Role::State::RUNNING : Role::State::WALKING
      end
    end
  end

  def start_eat_food(food)
    @role.start_eat food
    @eating_food_vm = FoodViewModel.new food
  end

  def eat
    @role.eat
    @eating_food_vm = nil unless @role.eating?
  end

  def auto_move(map_vm)
    if @auto_move_enabled
      x_diff = @auto_move_dest[:x] - @role.x
      y_diff = @auto_move_dest[:y] - @role.y
      if x_diff.abs > y_diff.abs
        @role.direction = x_diff < 0 ? Direction::LEFT : Direction::RIGHT
      else
        @role.direction = y_diff < 0 ? Direction::UP : Direction::DOWN
      end
      do_move @auto_move_angle, map_vm, @auto_move_dest
    end
  end

  def do_move(angle, map_vm, destination = nil)
    @running = @role.hp > 0
    speed = get_speed

    unless destination.nil?
      dest_x = destination[:x]
      dest_y = destination[:y]
      if Gosu::distance(@role.x, @role.y, dest_x, dest_y) <= speed
        move_to_location(dest_x, dest_y)
        complete_auto_move
        @running = false
        @standing = true
        return
      end
    end

    x = @role.x + Gosu::offset_x(angle, speed)
    y = @role.y + Gosu::offset_y(angle, speed)

    if map_vm.tile_block? x, y
      disable_auto_move
      # 继续单方向检测
      @running = false
      @standing = true
      move_to_location(x, @role.y) unless map_vm.tile_block? x, @role.y
      move_to_location(@role.x, y) unless map_vm.tile_block? @role.x, y
    else
      move_to_location(x, y)
    end
  end

  def get_speed
    @running ? @speed * 2 : @speed
  end

  def move_to_location(x, y)
    @standing = false
    @role.x = x
    @role.y = y
    @move_timestamp = Gosu::milliseconds
    @role.dec_hp(GameConfig::RUNNING_HP_DEC) if @running
  end

  def have_a_rest
    @role.inc_hp(GameConfig::REST_HP_INC)
  end

  def complete_auto_move
    disable_auto_move
    item_vms = @map_service.current_map.current_area.food_vms
    pick_up(item_vms, @auto_pick_up_item) unless @auto_pick_up_item.nil?
  end
end