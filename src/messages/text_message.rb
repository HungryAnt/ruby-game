require 'json'

class TextMessage
  attr_accessor :sender, :content, :version

  def initialize(sender, content, version=-1)
    @sender, @content = sender, content
    @version = version
  end

  def use_version?
    version >= 0
  end

  def type
    'text_message'
  end

  def to_json(*a)
    {
        type: type,
        data: {sender: @sender, content: @content, version: @version}
    }.to_json(*a)
  end

  def self.json_create(map)
    new(map['data']['sender'],
        map['data']['content'],
        map['data']['version'].to_i)
  end
end

