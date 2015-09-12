class ChatBoardViewModel
  attr_reader :msgs

  def initialize
    autowired(CommunicationService)
    @msgs = []
    @revision = nil
  end

  def update
    if @revision.nil? || @revision != @communication_service.revision
      @msgs = @communication_service.get_latest_msgs
    end
  end
end