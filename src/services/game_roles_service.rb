class GameRolesService
  def initialize
    @mutex = Mutex.new
    @role_msg_call_back = nil
    @delete_role_call_back = nil
    @role_dict = {} # area_id => []

    @eating_food_call_back = nil
    @eat_up_food_call_back = nil

    @chat_call_back = nil
  end

  def register_role_msg_call_back(&role_msg_call_back)
    @role_msg_call_back = role_msg_call_back
  end

  def register_delete_role_call_back(&delete_role_call_back)
    @delete_role_call_back = delete_role_call_back
  end

  def register_eating_food_call_back(&eating_food_call_back)
    @eating_food_call_back = eating_food_call_back
  end

  def register_eat_up_food_call_back(&eat_up_food_call_back)
    @eat_up_food_call_back = eat_up_food_call_back
  end

  def register_chat_call_back(&chat_call_back)
    @chat_call_back = chat_call_back
  end

  def add_role_msg(role_msg)
    # @mutex.synchronize {
    #   area_id = role_msg.role_map['area_id'].to_sym
    #   role_msgs = @role_dict[area_id]
    #   if role_msgs.nil?
    #     role_msgs = []
    #     @role_dict[area_id] = role_msgs
    #   end
    # }
    @role_msg_call_back.call role_msg
  end

  def delete_role(user_id)
    @delete_role_call_back.call user_id
  end

  def eating_food(user_id, food_type_id)
    @eating_food_call_back.call user_id, food_type_id
  end

  def eat_up_food(user_id)
    @eat_up_food_call_back.call user_id
  end

  def chat(user_id, user_name, content)
    @chat_call_back.call user_id, user_name, content
  end
end