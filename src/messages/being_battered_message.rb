class BeingBatteredMessage
  attr_reader :user_id, :hit_type

  def initialize(user_id, hit_type)
    @user_id, @hit_type = user_id, hit_type
  end

  def to_json(*a)
    {
        type: 'being_battered_message',
        data: {user_id: @user_id, hit_type:@hit_type.to_s}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['hit_type'].to_sym)
  end
end