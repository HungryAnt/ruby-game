class SmashMonsterMessage
  attr_reader :user_id, :area_id, :monster_id

  def initialize(user_id, area_id, monster_id)
    @user_id, @area_id, @monster_id = user_id, area_id, monster_id
  end

  def to_json(*a)
    {
        type: 'smash_monster_message',
        data: {
            user_id: @user_id,
            area_id: @area_id,
            monster_id: @monster_id
        }
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['id'],
        map['data']['user_id'],
        map['data']['area_id'],
        map['data']['monster_id'])
  end
end