module GameShitMine
  def init_shit_mines
    @shit_mine_message_handler.register_bomb_callback do |shit_mine_message|
      if shit_mine_message.action == ShitMineMessage::SETUP
        mine = ShitMine.new shit_mine_message.id, shit_mine_message.user_id,
                            shit_mine_message.x, shit_mine_message.y
        mine_vm = ShitMineViewModel.new mine
        get_current_area.add_shit_mine_vm mine_vm
      elsif shit_mine_message.action == ShitMineMessage::BOMB
        get_current_area.get_shit_mine_vms.each do |shit_mine_vm|
          shit_mine_vm.bomb if shit_mine_vm.id == shit_mine_message.id
        end
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
end