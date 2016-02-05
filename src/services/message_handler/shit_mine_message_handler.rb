class ShitMineMessageHandler
  def initialize
    @shit_mine_bomb_callback = nil
  end

  def register_bomb_callback(&callback)
    @shit_mine_bomb_callback = callback
  end

  def bomb(shit_mine_message)
    @shit_mine_bomb_callback.call shit_mine_message
  end
end