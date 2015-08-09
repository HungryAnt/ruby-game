class RoleMessage
  attr_reader :user_id, :role_map, :area_id

  def initialize(user_id, user_name, role_map, area_id)
    @user_id, @user_name = user_id, user_name
    @role_map = role_map
    @area_id = area_id
  end

  def to_json(*a)
    {
        type: 'role_message',
        data: {user_id: @user_id, user_name: @user_name, role:@role_map, area_id:@area_id.to_s}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'], map['data']['user_name'], map['data']['role_map'], map['data']['area_id'].to_sym)
  end
end