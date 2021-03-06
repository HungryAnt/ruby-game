class JoinMessage
  attr_reader :user_id, :user_name, :lv, :map_id

  def initialize(user_id, user_name, lv, map_id)
    @user_id, @user_name, @lv, @map_id = user_id, user_name, lv, map_id
  end

  def to_json(*a)
    {
        type: 'join_message',
        data: {user_id: @user_id, user_name: @user_name, lv: @lv, map_id: @map_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['user_name'], map['data']['lv'], map['data']['map_id'])
  end
end