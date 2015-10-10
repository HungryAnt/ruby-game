class SmashLargeRubbishMessage
  attr_reader :user_id, :large_rubbish_id

  def initialize(user_id, large_rubbish_id)
    @user_id, @large_rubbish_id = user_id, large_rubbish_id
  end

  def to_json(*a)
    {
        type: 'smash_large_rubbish_message',
        data: {user_id: @user_id, large_rubbish_id: @large_rubbish_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['large_rubbish_id'])
  end
end