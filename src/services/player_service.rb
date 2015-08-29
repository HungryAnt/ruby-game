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
    [39, 40, 50, 58, 59, 67, 74, 75, 81, 82, 83, 89, 604, 828].each do |num|
      vehicle_key = "vehicle_#{num}".to_sym
      @role.package << Equipment.new(Equipment::Type::VEHICLE, vehicle_key)
    end

    @chat_service.init_sync_user @user_id, user_name
  end

  def update_lv
    @role.update_lv @user_service.lv, @user_service.exp
  end
end