class EatingFoodMessage
  attr_reader :user_id, :food_map

  def initialize(user_id, food_map)
    @user_id, @food_map = user_id, food_map
  end

  def to_json(*a)
    {
        type: 'eating_food_message',
        data: {user_id: @user_id, food_map: @food_map}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_id'], map['data']['food_map'])
  end
end