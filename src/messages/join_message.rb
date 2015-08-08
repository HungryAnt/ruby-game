require 'json'

class JoinMessage
  attr_accessor :user_id, :user_name

  def initialize(user_id, user_name)
    @user_id, @user_name = user_id, user_name
  end

  def to_json(*a)
    {
        type: 'join_message',
        data: {user_id: @user_id, user_name: @user_name}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'], map['data']['user_name'])
  end
end