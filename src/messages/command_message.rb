class CommandMessage
  attr_reader :cmd, :user_id, :map_id, :area_id

  def initialize(cmd, user_id, map_id, area_id)
    @cmd, @user_id, @map_id, @area_id = cmd, user_id, map_id, area_id
  end

  def to_json(*a)
    {
        type: 'command_message',
        data: {cmd: @cmd, user_id: @user_id, map_id: @map_id, area_id: @area_id}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['cmd'], map['data']['user_id'], map['data']['map_id'], map['data']['area_id'])
  end
end