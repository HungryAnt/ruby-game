class ShitMineMessage
  SETUP = 'setup'
  BOMB = 'bomb'

  attr_accessor :id
  attr_reader :user_id, :area_id, :x, :y, :action

  def initialize(id, user_id, area_id, x, y, action)
    @id, @user_id = id, user_id
    @area_id, @x, @y = area_id, x, y
    @action = action
  end

  def to_json(*a)
    {
        type: 'shit_mine_message',
        data: {
            id: @id,
            user_id: @user_id,
            area_id: @area_id,
            x: @x,
            y: @y,
            action: @action
        }
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['id'], map['data']['user_id'],
        map['data']['area_id'], map['data']['x'].to_i, map['data']['y'].to_i,
        map['data']['action'])
  end
end