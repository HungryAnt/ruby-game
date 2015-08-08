require 'socket'

class NetworkService
  attr_reader :connection_error

  def initialize
    autowired(MessageHandlerService)
    @connection_error = nil
  end

  def connect(hostname, port)
    begin
      @connection_error = nil
      @s = TCPSocket.open(hostname, port)
      start_msg_loop
      return true
    rescue Exception => e
      @connection_error = e.message
      return false
    end
  end

  def has_error?
    !@connection_error.nil?
  end

  def send(data)
    return if has_error?
    puts "[send data]: #{data}"
    @s.puts(data)
  end

  def start_msg_loop
    init_message_handler
    Thread.new {
      begin
        while (line = @s.gets("\n"))
          next if line.nil?
          line = line.chomp.gsub /\n|\r/, ''
          next if line == ''
          msg_map = JSON.parse(line)
          @message_handler_service.process msg_map
        end
      rescue Exception => e
        puts 'get_messages raise exception:'
        puts e.message
        puts e.backtrace.inspect
      end
    }
  end

  private
  def init_message_handler
    register('text_message') do |msg_map, params|
      text_message = TextMessage.json_create(msg_map)
      puts "[#{text_message.sender}: #{text_message.content}]"
      if text_message.use_version?
        @current_version = text_message.version + 1
      end
    end
  end

  def register(msg_type, &handler)
    @message_handler_service.register msg_type, &handler
  end
end