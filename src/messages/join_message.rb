require 'json'

class JoinMessage
  attr_accessor :user_id, :user_name

  def initialize(user_id, user_name, map_id)
    @user_id, @user_name, @map_id = user_id, user_name, map_id
  end

  def to_json(*a)
    {
        type: 'join_message',
        data: {user_id: @user_id, user_name: @user_name, map_id: @map_id}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'], map['data']['user_name'], map['data']['map_id'].to_i)
  end
end