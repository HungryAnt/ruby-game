class ChatService
  attr_reader :revision

  def initialize
    autowired(NetworkService, UserService, GameRolesService, AreaItemsService)
    @mutex = Mutex.new
    @chat_msgs = []
    @revision = 0
    init_message_handler
  end

  def init_sync_user(user_id, user_name)
    init_sync_user_msg = InitSyncUserMessage.new(user_id, user_name)
    send init_sync_user_msg
  end

  def chat(msg)
    puts 'chat'
    chat_msg = ChatMessage.new(@user_service.user_id, @user_service.user_name, msg)
    send chat_msg
  end

  def command(cmd, user_id, map_id, area_id)
    cmd_msg = CommandMessage.new(cmd, user_id, map_id, area_id)
    send cmd_msg
  end

  def join(map_id, role)
    puts 'join'
    join_msg = JoinMessage.new(@user_service.user_id, @user_service.user_name, role.lv, map_id)
    puts join_msg.to_json
    send join_msg
  end

  def quit(map_id)
    puts 'quit'
    quit_map = QuitMessage.new(@user_service.user_id, @user_service.user_name, map_id)
    send quit_map
  end

  def send_role_message(role_map)
    puts 'send_role_message'
    role_msg = RoleMessage.new(@user_service.user_id, @user_service.user_name, role_map)
    send role_msg
  end

  def send_roles_query_message(map_id)
    puts 'send_roles_query_message'
    roles_query_msg = RolesQueryMessage.new map_id
    send roles_query_msg
  end

  def send_area_items_query_message(map_id)
    puts "send_area_items_query_message map_id:#{map_id}"
    query_msg = AreaItemsQueryMessage.new map_id
    send query_msg
  end

  def send_try_pickup_item_message(user_id, area_id, item_id)
    puts "send_area_items_query_message user_id:#{user_id} area_id:#{area_id} item_id:#{item_id}"
    try_pickup_item_msg = TryPickupItemMessage.new(user_id, area_id, item_id)
    send try_pickup_item_msg
  end

  def send_discard_item_message(area_id, item_map)
    puts 'send_discard_item_message'
    discard_item_msg = DiscardItemMessage.new(area_id, item_map)
    send discard_item_msg
  end

  def send_eating_food_message(user_id, food_map)
    puts 'send_eating_food_message'
    eating_food_msg = EatingFoodMessage.new(user_id, food_map)
    send eating_food_msg
  end

  def send_eat_up_food_message(user_id)
    puts 'send_eat_up_food_message'
    eat_up_food_msg = EatUpFoodMessage.new(user_id)
    send eat_up_food_msg
  end

  def send_update_lv(user_id, lv, exp)
    puts 'send_update_lv'
    send UpdateLvMessage.new(user_id, lv, exp)
  end

  def add_chat_msg(msg)
    @mutex.synchronize {
      @revision += 1
      @chat_msgs << msg
    }
  end

  def clear_chat_msgs
    @mutex.synchronize {
      @revision += 1
      @chat_msgs.clear
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
    @network_service.register('lv_message') do |msg_map, params|
      lv_msg = LvMessage.from_map(msg_map)
      @user_service.update_lv_exp lv_msg.lv, lv_msg.exp
    end

    @network_service.register('chat_message') do |msg_map, params|
      chat_msg = ChatMessage.from_map(msg_map)
      # puts "[#{text_message.sender}: #{text_message.content}]"
      add_chat_msg chat_msg
      @game_roles_service.chat chat_msg.user_id, chat_msg.user_name, chat_msg.content
    end

    @network_service.register('system_message') do |msg_map, params|
      sys_msg = SystemMessage.from_map(msg_map)
      add_chat_msg sys_msg
    end

    @network_service.register('quit_message') do |msg_map, params|
      quit_msg = QuitMessage.from_map(msg_map)
      @game_roles_service.delete_role quit_msg.user_id
    end

    @network_service.register('role_message') do |msg_map, params|
      role_msg = RoleMessage.from_map(msg_map)
      @game_roles_service.add_role_msg role_msg
    end

    @network_service.register('area_item_message') do |msg_map, params|
      area_item_msg = AreaItemMessage.from_map(msg_map)
      @area_items_service.add_item_msg area_item_msg
    end

    @network_service.register('eating_food_message') do |msg_map, params|
      eating_food_msg = EatingFoodMessage.from_map(msg_map)
      @game_roles_service.eating_food eating_food_msg.user_id, eating_food_msg.food_map['food_type_id'].to_i
    end

    @network_service.register('eat_up_food_message') do |msg_map, params|
      eat_up_food_msg = EatUpFoodMessage.from_map(msg_map)
      @game_roles_service.eat_up_food eat_up_food_msg.user_id
    end
  end

  def send(msg)
    @network_service.send msg.to_json
  end
end