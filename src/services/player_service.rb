# coding: UTF-8

class PlayerService
  attr_reader :player

  def initialize
    autowired(UserService)
  end

  def init
    user_name = @user_service.user_name
    puts "player name: #{user_name}"
    role_type = [RoleType::WAN_GYE, RoleType::SALARY][rand(2)]
    @player = Role.new(user_name, role_type, 100, 300)
  end
end