# coding: UTF-8

class PlayerService
  attr_reader :role, :user_id

  def initialize
    autowired(UserService, ChatService)
    @user_id = ''
  end

  def init
    @user_id = @user_service.user_id
    user_name = @user_service.user_name
    puts "player name: #{user_name}"
    role_type = [RoleType::WAN_GYE, RoleType::SALARY][rand(2)]
    @role = Role.new(user_name, role_type, 100, 300)
    @role.package << Equipment.new(Equipment::Type::VEHICLE, :car_604)
    @role.package << Equipment.new(Equipment::Type::VEHICLE, :car_828)
    @role.package << Equipment.new(Equipment::Type::VEHICLE, :car_39)
    @role.package << Equipment.new(Equipment::Type::VEHICLE, :car_40)
    @chat_service.init_sync_user @user_id, user_name
  end

  def update_lv
    @role.update_lv @user_service.lv, @user_service.exp
  end
end