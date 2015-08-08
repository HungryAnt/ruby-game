require 'socket'

class NetworkService
  attr_reader :connection_error

  def initialize
    @connection_error = nil
  end

  def connect(hostname, port)
    begin
      @s = TCPSocket.open(hostname, port)
      return true
    rescue Exception => e
      @connection_error = e.message
      return false
    end
  end

  def has_error?
    !@connection_error.nil?
  end
end