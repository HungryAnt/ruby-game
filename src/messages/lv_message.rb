class LvMessage
  attr_reader :user_id, :lv, :exp

  def initialize(user_id, lv, exp)
    @user_id, @lv, @exp = user_id, lv, exp
  end

  def to_json(*a)
    {
        type: 'lv_message',
        data: {user_id: @user_id, lv: @lv, exp: @exp}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'],
        map['data']['lv'].to_i,
        map['data']['exp'].to_i)
  end
end