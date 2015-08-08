class ChatBoardView
  def initialize

  end

  def update

  end

  def draw
    Gosu::draw_rect(0, 0, GameConfig::CHAT_BOARD_WIDTH, GameConfig::CHAT_BOARD_HEIGHT,
                    0x80_000000, ZOrder::UI)
    GraphicsUtil::draw_rect_border(0, 0, GameConfig::CHAT_BOARD_WIDTH, GameConfig::CHAT_BOARD_HEIGHT,
                                   0x80_FFFFFF, ZOrder::UI)
  end
end