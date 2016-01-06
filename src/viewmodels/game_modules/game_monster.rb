module GameMonster
  def init_monsters
    @monsters_service.register_monster_msg_callback do |monster_msg|
      area_id = monster_msg.area_id
      item_map = monster_msg.item_map
      detail = monster_msg.detail
      area_vm = @map_service.get_area(area_id)
      monster_id = item_map['id']
      quiet = !is_current_area(area_id.to_sym)

      case monster_msg.action
        when MonsterMessage::Action::CREATE
          area_vm.add_monster_vm MonsterViewModelFactory.create_monster_vm(item_map)
        when MonsterMessage::Action::UPDATE
          update_monster area_vm, item_map
        when MonsterMessage::Action::UPDATE_HP
          area_vm.update_monster_hp MonsterViewModelFactory.to_monster(item_map)
        when MonsterMessage::Action::MOVE
          update_monster area_vm, item_map
          area_vm.monster_move_to monster_id, detail['x'].to_i, detail['y'].to_i, quiet
        when MonsterMessage::Action::ATTACK
          update_monster area_vm, item_map
          area_vm.monster_attack monster_id, quiet
        when MonsterMessage::Action::DESTROY
          area_vm.destroy_monster_vm monster_id, quiet
          @player_view_model.stop_smash_enemy monster_id
      end
    end
  end

  def refresh_monster_vms
    @map_service.current_map.current_area.refresh_monster_vms
  end

  def get_monster_vms
    @map_service.current_map.current_area.get_monster_vms
  end

  def travel_monsters
    refresh_monster_vms.each { |monster_vm| yield monster_vm }
  end

  def monster_move_to(x, y, quiet=false)
    return if get_monster_vms.count == 0
    get_monster_vms.each { |monster_vm| monster_vm.move_to x, y, quiet }
  end

  def monster_atack(quiet)
    get_monster_vms.each { |monster_vm| monster_vm.attack quiet }
  end

  # def set_monster_action(state)
  #   get_monster_vms.each { |monster_vm| monster_vm.set_durable_state state }
  # end

  def get_touch_monster(actual_x, actual_y)
    get_monster_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(actual_x, actual_y)
    end
    nil
  end

  private

  def update_monster(area_vm, item_map)
    area_vm.update_monster_vm MonsterViewModelFactory.create_monster_vm(item_map)
  end
end