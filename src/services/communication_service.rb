class CommunicationService
  attr_reader :revision

  def initialize
    autowired(NetworkService, UserService,
              GameRolesCommunicationHandler, PetCommunicationHandler,
              AreaItemsService, MapUserCountService, LargeRubbishesService)
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

  def send_area_large_rubbishes_query_message(map_id)
    puts "send_area_large_rubbish_query_message map_id:#{map_id}"
    msg = AreaLargeRubbishesQueryMessage.new map_id
    send msg
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

  def send_inc_exp_message(user_id, exp)
    puts 'send_inc_exp_message'
    send IncExpMessage.new(user_id, exp)
  end

  def send_hit_message(user_id, area_id, hit_type, target_x, target_y)
    puts 'send_hit_message'
    send HitMessage.new(user_id, area_id, hit_type, target_x, target_y)
  end

  def send_being_battered_message(user_id, hit_type)
    puts 'send_being_battered_message'
    send BeingBatteredMessage.new(user_id, hit_type)
  end

  def send_collect_rubbish_message(user_id, rubbish_map)
    puts 'send_collect_rubbish_message'
    send CollectingRubbishMessage.new(user_id, rubbish_map)
  end

  def send_collect_nutrient_message(user_id, nutrient_map)
    puts 'send_collect_nutrient_message'
    send CollectingNutrientMessage.new(user_id, nutrient_map)
  end

  def send_smash_large_rubbish_message(user_id, area_id, large_rubbish_id)
    puts 'send_smash_large_rubbish_message'
    send SmashLargeRubbishMessage.new(user_id, area_id, large_rubbish_id)
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

  def send_pet_message(pet_msg)
    puts 'send_pet_message'
    send pet_msg
  end

  private
  def init_message_handler
    @network_service.register('res_sync_user_message') do |msg_map, params|
      res_sync_user_msg = ResSyncUserMessage.from_map(msg_map)
      @user_service.update_user_data res_sync_user_msg.lv, res_sync_user_msg.exp,
                                     res_sync_user_msg.vehicles, res_sync_user_msg.rubbishes,
                                     res_sync_user_msg.nutrients
    end

    @network_service.register('update_lv_message') do |msg_map, params|
      msg = UpdateLvMessage.from_map(msg_map)
      if @user_service.user_id == msg.user_id
        @user_service.update_lv msg.lv, msg.exp
      end
    end

    @network_service.register('chat_message') do |msg_map, params|
      chat_msg = ChatMessage.from_map(msg_map)
      # puts "[#{text_message.sender}: #{text_message.content}]"
      add_chat_msg chat_msg
      @game_roles_communication_handler.chat chat_msg.user_id, chat_msg.user_name, chat_msg.content
    end

    @network_service.register('system_message') do |msg_map, params|
      sys_msg = SystemMessage.from_map(msg_map)
      add_chat_msg sys_msg
    end

    @network_service.register('quit_message') do |msg_map, params|
      quit_msg = QuitMessage.from_map(msg_map)
      @game_roles_communication_handler.delete_role quit_msg.user_id
    end

    @network_service.register('role_message') do |msg_map, params|
      role_msg = RoleMessage.from_map(msg_map)
      @game_roles_communication_handler.add_role_msg role_msg
    end

    @network_service.register('area_item_message') do |msg_map, params|
      area_item_msg = AreaItemMessage.from_map(msg_map)
      @area_items_service.add_item_msg area_item_msg
    end

    @network_service.register('eating_food_message') do |msg_map, params|
      eating_food_msg = EatingFoodMessage.from_map(msg_map)
      @game_roles_communication_handler.eating_food eating_food_msg.user_id, eating_food_msg.food_map['food_type_id'].to_i
    end

    @network_service.register('eat_up_food_message') do |msg_map, params|
      eat_up_food_msg = EatUpFoodMessage.from_map(msg_map)
      @game_roles_communication_handler.eat_up_food eat_up_food_msg.user_id
    end

    @network_service.register('hit_message') do |msg_map, params|
      hit_msg = HitMessage.from_map(msg_map)
      @game_roles_communication_handler.hit hit_msg.user_id, hit_msg.area_id.to_sym,
                              hit_msg.hit_type.to_sym, hit_msg.target_x, hit_msg.target_y
    end

    @network_service.register('being_battered_message') do |msg_map, params|
      being_battered_msg = BeingBatteredMessage.from_map(msg_map)
      @game_roles_communication_handler.being_battered being_battered_msg.user_id, being_battered_msg.hit_type
    end

    @network_service.register('collecting_rubbish_message') do |msg_map, params|
      collecting_rubbish_msg = CollectingRubbishMessage.from_map(msg_map)
      @game_roles_communication_handler.collecting_rubbish collecting_rubbish_msg.user_id
    end

    @network_service.register('collecting_nutrient_message') do |msg_map, params|
      collecting_nutrient_msg = CollectingNutrientMessage.from_map(msg_map)
      @game_roles_communication_handler.collecting_nutrient collecting_nutrient_msg.user_id
    end

    @network_service.register('map_user_count_message') do |msg_map, params|
      map_user_count_msg = MapUserCountMessage.from_map(msg_map)
      @map_user_count_service.refresh_map_user_count map_user_count_msg.map_user_count_dict,
                                                     map_user_count_msg.all_user_count,
                                                     map_user_count_msg.map_large_rubbish_dict
    end

    @network_service.register('large_rubbish_message') do |msg_map, params|
      msg = LargeRubbishMessage.from_map msg_map
      @large_rubbishes_service.add_large_rubbish_msg msg
    end

    @network_service.register('smash_large_rubbish_message') do |msg_map, params|
      msg = SmashLargeRubbishMessage.from_map(msg_map)
      @game_roles_communication_handler.smash msg.user_id, msg.area_id.to_sym
    end

    @network_service.register('pet_message') do |msg_map, params|
      msg = PetMessage.from_map(msg_map)
      @pet_communication_handler.update_pet msg
    end
  end

  def send(msg)
    @network_service.send msg.to_json
  end
end