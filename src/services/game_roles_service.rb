class GameRolesService
  def initialize
    @mutex = Mutex.new
    @role_msg_call_back = nil
    @role_dict = {} # area_id => []
  end

  def register_role_msg_call_back(&role_msg_call_back)
    @role_msg_call_back = role_msg_call_back
  end

  def register_delete_role_call_back(&delete_role_call_back)
    @delete_role_call_back = delete_role_call_back
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
end