module GameShitMine
  def init_shit_mines
    @shit_mine_message_handler.register_bomb_callback do |shit_mine_message|
      if shit_mine_message.action == ShitMineMessage::SETUP
        mine = ShitMine.new shit_mine_message.id, shit_mine_message.user_id,
                            shit_mine_message.x, shit_mine_message.y
        mine_vm = ShitMineViewModel.new mine
        area_vm = @map_service.get_area shit_mine_message.area_id
        area_vm.add_shit_mine_vm mine_vm unless area_vm.nil?
      elsif shit_mine_message.action == ShitMineMessage::BOMB
        map_area_shit_mine_bomb shit_mine_message.id
      end
    end
  end

  def setup_mine
    @player_view_model.setup_mine
  end

  def bomb_mine
    get_current_area.get_shit_mine_vms.each { |shit_mine_vm| shit_mine_vm.bomb }
  end

  def travel_shit_mines
    get_current_area.refresh_shit_mine_vms.each { |shit_mine_vm| yield shit_mine_vm }
  end

  private

  def map_area_shit_mine_bomb(shit_mine_id)
    get_current_map.areas.each do |area_vm|
      area_vm.get_shit_mine_vms.each do |shit_mine_vm|
        if shit_mine_vm.id == shit_mine_id
          shit_mine_vm.bomb
          return
        end
      end
    end
  end
end