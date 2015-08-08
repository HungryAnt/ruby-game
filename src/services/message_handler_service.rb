class MessageHandlerService
  def initialize
    @handler_map = {}
  end

  def register(msg_type, &handler)
    @handler_map[msg_type] = handler
  end

  def process(msg_map, params={})
    msg_type = msg_map['type']
    puts "process #{msg_type}"
    return if msg_type.nil?
    return unless @handler_map.include? msg_type
    @handler_map[msg_type].call msg_map, params
  end
end