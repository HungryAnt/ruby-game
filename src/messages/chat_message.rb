require 'json'

class ChatMessage
  attr_accessor :sender, :content

  def initialize(sender, content)
    @sender, @content = sender, content
  end

  def to_json(*a)
    {
        type: 'chat_message',
        data: {sender: @sender, content: @content}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['sender'],
        map['data']['content'])
  end

  def to_s
    "#{@sender}: #{@content}"
  end
end

