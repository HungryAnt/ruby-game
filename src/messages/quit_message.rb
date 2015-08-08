require 'json'

class QuitMessage
  attr_accessor :user_name

  def initialize(user_name)
    @user_name = user_name
  end

  def to_json(*a)
    {
        type: 'quit_message',
        data: {user_name: @user_name}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['user_name'])
  end
end