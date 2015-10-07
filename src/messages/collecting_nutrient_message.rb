class CollectingNutrientMessage
  attr_reader :user_id, :nutrient_map

  def initialize(user_id, nutrient_map)
    @user_id, @nutrient_map = user_id, nutrient_map
  end

  def to_json(*a)
    {
        type: 'collecting_nutrient_message',
        data: {user_id: @user_id, nutrient_map: @nutrient_map}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['nutrient_map'])
  end
end