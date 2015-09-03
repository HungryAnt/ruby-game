class HitMessage
  attr_reader :user_id, :area_id, :target_x, :target_y

  def initialize(user_id, area_id, target_x, target_y)
    @user_id, @area_id, @target_x, @target_y = user_id, area_id, target_x, target_y
  end

  def to_json(*a)
    {
        type: 'hit_message',
        data: {user_id: @user_id, area_id:@area_id, target_x: @target_x, target_y: @target_y}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'], map['data']['area_id'], map['data']['target_x'].to_i, map['data']['target_y'].to_i)
  end
end