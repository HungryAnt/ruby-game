class UiControlViewModel
  attr_reader :chat_board_visible, :actions_bar_visible

  def initialize
    @chat_board_visible = true
    @actions_bar_visible = true
  end

  def chat_board_location
    x = GameConfig::CHAT_BOARD_LEFT
    y = GameConfig::MAP_HEIGHT - GameConfig::CHAT_BOARD_HEIGHT
    y = y - GameConfig::ACTIONS_BAR_HEIGHT if @actions_bar_visible
    [x, y]
  end

  def actions_bar_location
    x = GameConfig::ACTIONS_BAR_LEFT
    y = GameConfig::MAP_HEIGHT - GameConfig::ACTIONS_BAR_HEIGHT
    [x, y]
  end

  def switch_chat_board_visible
    @chat_board_visible = !@chat_board_visible
  end

  def switch_actions_bar_visible
    @actions_bar_visible = !@actions_bar_visible
  end
end