module GameMonster
  def init_monsters
    @monsters_service.register_monster_msg_callback do |monster_msg|
      area_id = monster_msg.area_id
      item_map = monster_msg.item_map
      area_vm = @map_service.get_area(area_id)
      case monster_msg.action
        when LargeRubbishMessage::Action::CREATE
          area_vm.add_monster_vm MonsterViewModelFactory.create_monster_vm(item_map)
        when LargeRubbishMessage::Action::UPDATE
          area_vm.update_monster_vm MonsterViewModelFactory.create_monster_vm(item_map)
        when LargeRubbishMessage::Action::DESTROY
          monster_id = item_map['id']
          area_vm.destroy_monster_vm monster_id
          @player_view_model.stop_smash_enemy monster_id
      end
    end

  end

  def get_monster_vms
    @map_service.current_map.current_area.get_monster_vms
  end

  def travel_monsters
    get_monster_vms.each { |monster_vm| yield monster_vm }
  end

  def monster_move_to(x, y)
    return if get_monster_vms.count == 0
    get_monster_vms.each { |monster_vm| monster_vm.move_to x, y }
  end

  def monster_atack
    get_monster_vms.each { |monster_vm| monster_vm.attack }
  end

  # def set_monster_action(state)
  #   get_monster_vms.each { |monster_vm| monster_vm.set_durable_state state }
  # end

  def get_touch_monster(mouse_x, mouse_y)
    get_monster_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(mouse_x, mouse_y)
    end
    nil
  end
end