class ChatMessage
  attr_accessor :user_id, :user_name, :content

  def initialize(user_id, user_name, content)
    @user_id, @user_name, @content = user_id, user_name, content
  end

  def to_json(*a)
    {
        type: 'chat_message',
        data: {user_id: @user_id, user_name: @user_name, content: @content}
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['user_id'],
        map['data']['user_name'],
        map['data']['content'])
  end

  def to_s
    "#{@user_name}: #{@content}"
  end
end

