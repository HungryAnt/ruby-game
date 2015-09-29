class ResSyncUserMessage
  attr_reader :user_id, :lv, :exp, :vehicles, :rubbishes

  def initialize(user_id, lv, exp, vehicles, rubbishes)
    @user_id, @lv, @exp, @vehicles, @rubbishes = user_id, lv, exp, vehicles, rubbishes
  end

  def to_json(*a)
    {
        type: 'res_sync_user_message',
        data: {user_id: @user_id, lv: @lv, exp: @exp, vehicles: @vehicles, rubbishes: @rubbishes}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'],
        map['data']['lv'].to_i,
        map['data']['exp'].to_i,
        map['data']['vehicles'],
        map['data']['rubbishes'])
  end
end