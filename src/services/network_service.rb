require 'socket'

class NetworkService
  attr_reader :connection_error

  def initialize
    autowired(MessageHandlerService, DesService)
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
    return if @des_service.waiting_for_password?
    # puts "[send data]: #{data}"
    encrypted_data = @des_service.encrypt data
    @s.puts(encrypted_data + "\n")
  end

  def start_msg_loop
    Thread.new {
      begin
        while (line = @s.gets("\n"))
          begin
            next if line.nil?
            line = line.chomp.gsub /\n|\r/, ''
            next if line == ''
            if @des_service.waiting_for_password?
              puts "password #{line}"
              @des_service.set_password line
              next
            end

            line = @des_service.decrypt line
            msg_map = JSON.parse(line)
            @message_handler_service.process msg_map
          rescue Exception => e
            puts "line: #{line}"
            puts "get_messages process line exception: #{e.message}"
            puts e.backtrace.inspect
          end
        end
      rescue Exception => e
        puts "get_messages raise exception: #{e.message}"
        puts e.backtrace.inspect
      end
    }
  end

  def register(msg_type, &handler)
    @message_handler_service.register msg_type, &handler
  end
end