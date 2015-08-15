class ChatService
  attr_reader :revision

  def initialize
    autowired(NetworkService, UserService, GameRolesService)
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

  def send_role_message(role_map)
    role_msg = RoleMessage.new(@user_service.user_id, @user_service.user_name, role_map)
    send role_msg
  end

  def send_roles_query_message(map_id)
    roles_query_msg = RolesQueryMessage.new map_id
    send roles_query_msg
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

    @network_service.register('quit_message') do |msg_map, params|
      quit_msg = QuitMessage.json_create(msg_map)
      @game_roles_service.delete_role quit_msg.user_id
    end

    @network_service.register('role_message') do |msg_map, params|
      role_msg = RoleMessage.json_create(msg_map)
      @game_roles_service.add_role_msg role_msg
    end
  end

  def send(msg)
    @network_service.send msg.to_json
  end
end