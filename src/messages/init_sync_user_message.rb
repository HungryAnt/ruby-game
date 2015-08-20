class InitSyncUserMessage
  attr_reader :user_id, :user_name

  def initialize(user_id, user_name)
    @user_id, @user_name = user_id, user_name
  end

  def to_json(*a)
    {
        type: 'init_sync_user_message',
        data: {user_id: @user_id, user_name: @user_name}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'], map['data']['user_name'])
  end
end