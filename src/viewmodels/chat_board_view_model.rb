class ChatBoardViewModel
  attr_reader :msgs

  def initialize
    autowired(ChatService)
    @msgs = []
    puts 'ok!!!!!!!!!!'
    @revision = nil
  end

  def update
    if @revision.nil? || @revision != @chat_service.revision
      @msgs = @chat_service.get_latest_msgs
    end
  end
end