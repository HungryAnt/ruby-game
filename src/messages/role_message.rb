class RoleMessage
  attr_reader :user_id, :role_map

  def initialize(user_id, user_name, role_map)
    @user_id, @user_name = user_id, user_name
    @role_map = role_map
  end

  def to_json(*a)
    {
        type: 'role_message',
        data: {user_id: @user_id, user_name: @user_name, role_map:@role_map}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['user_name'], map['data']['role_map'])
  end
end