class EatUpFoodMessage
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def to_json(*a)
    {
        type: 'eat_up_food_message',
        data: {user_id: @user_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'])
  end
end