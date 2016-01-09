class IncExpMessage
  attr_reader :user_id, :food_exp_infos

  def initialize(user_id, food_exp_infos)
    @user_id, @food_exp_infos = user_id, food_exp_infos
  end

  def to_json(*a)
    {
        type: 'inc_exp_message',
        data: {user_id: @user_id, food_exp_infos: @food_exp_infos}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'],
        map['data']['food_exp_infos'])
  end
end