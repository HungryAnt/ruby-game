class BeingBatteredMessage
  attr_reader :user_id, :hit_type, :from_user_id

  def initialize(user_id, hit_type, from_user_id)
    @user_id, @hit_type, @from_user_id = user_id, hit_type, from_user_id
  end

  def to_json(*a)
    {
        type: 'being_battered_message',
        data: {user_id: @user_id, hit_type: @hit_type.to_s, from_user_id: @from_user_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['hit_type'].to_sym, map['data']['from_user_id'])
  end
end