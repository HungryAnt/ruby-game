module GameLargeRubbish
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
          @player_view_model.stop_smash_enemy large_rubbish_id
      end
    end
  end

  private

  def get_large_rubbish_vms
    @map_service.current_map.current_area.get_large_rubbish_vms
  end

  def get_touch_rubbish(actual_x, actual_y)
    get_large_rubbish_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(actual_x, actual_y)
    end
    nil
  end
end