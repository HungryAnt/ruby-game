class Application
  VERSION = 'v0.7.1 beta'

  def start_up
    @start_up_window = StartUpLoadingWindow.new VERSION
    @start_up_window.init_load_resources do
      yield
    end
  end

  def init
    autowired(NetworkService, UserService, CommunicationService)
  end

  def run
    @network_service.connect(NetworkConfig::HOST_NAME, NetworkConfig::PORT)
    window = MainWindow.new VERSION
    window.show
  end
end