class Application
  def initialize
    autowired(NetworkService, UserService, ChatService)
  end

  def init

  end

  def run
    @network_service.connect(NetworkConfig::HOST_NAME, NetworkConfig::PORT)
    window = MainWindow.new
    window.show
  end
end