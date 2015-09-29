class CollectingRubbishMessage
  attr_reader :user_id, :rubbish_map

  def initialize(user_id, rubbish_map)
    @user_id, @rubbish_map = user_id, rubbish_map
  end

  def to_json(*a)
    {
        type: 'collecting_rubbish_message',
        data: {user_id: @user_id, rubbish_map: @rubbish_map}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['rubbish_map'])
  end
end