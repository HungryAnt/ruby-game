class ChatService
  attr_reader :revision

  def initialize
    autowired(NetworkService, UserService)
    @mutex = Mutex.new
    @text_msgs = []
    @revision = 0
    init_message_handler
  end

  def chat(msg)
    text_mgs = TextMessage.new(@user_service.user_name, msg)
    @network_service.send text_mgs.to_json
  end

  def add_text_msg(text_msg)
    @mutex.synchronize {
      @revision += 1
      @text_msgs << text_msg
    }
  end

  def get_latest_msgs
    latest_msgs_max_count = 8
    @mutex.synchronize {
      return [] if @text_msgs.size == 0
      start = [0, @text_msgs.size - latest_msgs_max_count].max
      return @text_msgs[start..-1]
    }
  end

  private
  def init_message_handler
    @network_service.register('text_message') do |msg_map, params|
      text_msg = TextMessage.json_create(msg_map)
      # puts "[#{text_message.sender}: #{text_message.content}]"
      add_text_msg text_msg
    end
  end
end