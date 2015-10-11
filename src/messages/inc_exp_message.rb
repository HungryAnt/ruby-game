class IncExpMessage
  attr_reader :user_id, :exp

  def initialize(user_id, exp)
    @user_id, @exp = user_id, exp
  end

  def to_json(*a)
    {
        type: 'inc_exp_message',
        data: {user_id: @user_id, exp: @exp}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'],
        map['data']['exp'].to_i)
  end
end