module GameAreaItems
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

  private

  def get_touch_item(actual_x, actual_y, item_vms)
    item_vms.each do |item_vm|
      return item_vm if item_vm.mouse_touch?(actual_x, actual_y)
    end
    nil
  end

  def get_item_vms
    @map_service.current_map.current_area.get_item_vms
  end
end