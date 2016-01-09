class PlayerPetViewModel < PetViewModel
  include PlayerCommonModule

  ONE_ATTACK_DURATION_TIME_IN_S = 1.6

  def initialize(pet)
    autowired(MapService, CommunicationService, PlayerService)
    @order_time_stamp = 0
    @target_enemy_vm = nil
    @attacking_enemy = false
    super
  end

  def appear_with_owner(role)
    @pet.x, @pet.y = role_side_location(role, 20)
    @pet.disable_auto_move
  end

  def order_move_to(target_x, target_y)
    move_to target_x, target_y
    @order_time_stamp = Gosu::milliseconds
  end

  def update(area, role)
    @update_times += 1
    if Gosu::milliseconds - @order_time_stamp > 8000
      enemy_vm = get_monster_vm area
      if enemy_vm.nil?
        # 无怪物，自由行动
        set_target_enemy nil

        if rand(5 * GameConfig::FPS) == 0
          rand_num = rand 10
          if rand_num < 4
            move_random area
          elsif rand_num < 6
            move_to_owner role
          else
            sleep
          end
        end
      else
        # 发现野怪，优先攻击野怪
        set_target_enemy enemy_vm
        if (@update_times % (GameConfig::FPS * ONE_ATTACK_DURATION_TIME_IN_S) == 0) && attacking_enemy?
          begin_attack
        end
      end
    end
    super(area)
  end

  def move_random(area)
    move_to *area.random_available_position
  end

  def move_to_owner(role)
    if Gosu::distance(x, y, role.x, role.y) < 55
      cute
    else
      move_to *role_side_location(role, 50)
    end
  end

  def move_to(target_x, target_y, &arrive_call_back)
    super
    remote_move_to target_x, target_y
  end

  def attack
    super
    remote_sync_data PetMessage::ATTACK
  end

  def sleep
    super
    remote_sync_data
  end

  def cute
    super
    remote_sync_data
  end

  def appear
    remote_sync_data
  end

  def disappear
    remote_sync_data PetMessage::DISAPPEAR
  end

  private

  def set_target_enemy(enemy_vm)
    if enemy_vm.nil?
      stop_attack
      return
    end

    if @target_enemy_vm != enemy_vm
      @target_enemy_vm = enemy_vm
      x, y = enemy_vm.get_destination @pet
      move_to(x, y) {
        appear
        @attacking_enemy = true
      }
    end
  end

  def attacking_enemy?
    @attacking_enemy && !@target_enemy_vm.nil?
  end

  def begin_attack
    return if !@attacking_enemy || @target_enemy_vm.nil?
    enemy_vm = @target_enemy_vm

    if enemy_vm.can_smash? @pet
      @pet.disable_auto_move
      attack
      @pet.adjust_to_suit_direction(enemy_vm.x, enemy_vm.y)
      remote_attack_enemy enemy_vm.enemy_type, enemy_vm.id
    else
      # 敌人已超出可攻击范围，停止攻击
      stop_attack
    end
  end

  def stop_attack
    @target_enemy_vm = nil
    @attacking_enemy = false
  end

  def role_side_location(role, offset)
    [role.x + offset - rand(offset*2), role.y + offset - rand(offset*2)]
  end

  def remote_move_to(target_x, target_y)
    destination = {x: target_x, y: target_y}
    remote_sync_data PetMessage::APPEAR, destination
  end

  def remote_sync_data(action = PetMessage::APPEAR, destination={})
    pet_msg = PetMessage.new @pet.pet_id, @pet.pet_type, action, @pet.to_map,
                             get_current_map_id, get_current_area_id,
                             destination
    @communication_service.send_pet_message pet_msg
  end

  def remote_attack_enemy(enemy_type, enemy_id)
    remote_sync_data PetMessage::ATTACK
    user_id = get_user_id
    area_id = get_current_area_id
    @communication_service.send_pet_attack_enemy_message pet_id, user_id, area_id, enemy_type, enemy_id
  end

  def get_monster_vm(area)
    area_vm = @map_service.get_area(area.id)
    area_vm.get_monster_vms.find { |monster_vm| !monster_vm.is_capitulate }
    # return nil if monster_vms.nil? || monster_vms.size == 0
    # monster_vms[0]
  end
end