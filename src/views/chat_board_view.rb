class ChatBoardView
  def initialize(chat_board_vm)
    @chat_board_vm = chat_board_vm
    @update_times = 0
    @font_msg = Gosu::Font.new(15)
    @line_height = 17
  end

  def update
    if @update_times % 6 == 0
      @chat_board_vm.update
    end

    @update_times += 1
  end

  def draw
    Gosu::draw_rect(0, 0, GameConfig::CHAT_BOARD_WIDTH, GameConfig::CHAT_BOARD_HEIGHT,
                    0x80_000000, ZOrder::UI)
    GraphicsUtil::draw_rect_border(0, 0, GameConfig::CHAT_BOARD_WIDTH, GameConfig::CHAT_BOARD_HEIGHT,
                                   0x80_FFFFFF, ZOrder::UI)
    # puts "chat_board_vm.msgs: #{@chat_board_vm.msgs}"
    @chat_board_vm.msgs.each_with_index do |msg, i|
      @font_msg.draw(msg.to_s,
                     0, i * @line_height, ZOrder::UI,
                     1.0, 1.0, 0xff_f0f0f0, :additive)
    end
  end
end