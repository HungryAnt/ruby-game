class QuitMessage
  attr_reader :user_id, :user_name, :map_id

  def initialize(user_id, user_name, map_id)
    @user_id, @user_name, @map_id = user_id, user_name, map_id
  end

  def to_json(*a)
    {
        type: 'quit_message',
        data: {user_id: @user_id, user_name: @user_name, map_id: @map_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['user_name'], map['data']['map_id'])
  end
end