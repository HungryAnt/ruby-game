class GameRolesService
  def initialize
    @mutex = Mutex.new
    @role_msg_call_back = nil
    @role_dict = {} # area_id => []
  end

  def register_role_msg_call_back(&role_msg_call_back)
    @role_msg_call_back = role_msg_call_back
  end

  def add_role_msg(role_msg)
    @mutex.synchronize {
      area_id = role_msg.area_id.to_sym
      role_maps = @role_dict[area_id]
      if role_maps.nil?
        role_maps = []
        @role_dict[area_id] = role_maps
      end
    }
    @role_msg_call_back.call role_msg
  end
end