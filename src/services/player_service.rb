# coding: UTF-8

class PlayerService
  attr_reader :player

  def initialize
    user_name = get_instance(UserService).user_name
    @player = Role.new(user_name, RoleType::WAN_GYE, 100, 300)
  end
end