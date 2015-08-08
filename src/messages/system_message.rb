# coding: UTF-8

class SystemMessage
  attr_accessor :content

  def initialize(content)
    @content = content
  end

  def to_json(*a)
    {
        type: 'system_message',
        data: {content: @content}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['content'])
  end

  def to_s
    @content
  end
end