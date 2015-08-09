class ChatService
  attr_reader :revision

  def initialize
    autowired(NetworkService, UserService)
    @mutex = Mutex.new
    @chat_msgs = []
    @revision = 0
    init_message_handler
  end

  def chat(msg)
    chat_msg = ChatMessage.new(@user_service.user_id, @user_service.user_name, msg)
    send chat_msg
  end

  def join(map_id)
    join_msg = JoinMessage.new(@user_service.user_id, @user_service.user_name, map_id)
    puts join_msg.to_json
    send join_msg
  end

  def quit(map_id)
    quit_map = QuitMessage.new(@user_service.user_id, @user_service.user_name, map_id)
    send quit_map
  end

  def add_chat_msg(msg)
    @mutex.synchronize {
      @revision += 1
      @chat_msgs << msg
    }
  end

  def get_latest_msgs
    latest_msgs_max_count = 7
    @mutex.synchronize {
      return [] if @chat_msgs.size == 0
      start = [0, @chat_msgs.size - latest_msgs_max_count].max
      return @chat_msgs[start..-1]
    }
  end

  private
  def init_message_handler
    @network_service.register('chat_message') do |msg_map, params|
      chat_msg = ChatMessage.json_create(msg_map)
      # puts "[#{text_message.sender}: #{text_message.content}]"
      add_chat_msg chat_msg
    end

    @network_service.register('system_message') do |msg_map, params|
      sys_msg = SystemMessage.json_create(msg_map)
      add_chat_msg sys_msg
    end
  end

  def send(msg)
    @network_service.send msg.to_json
  end
end