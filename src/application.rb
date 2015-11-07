class Application
  VERSION = 'v0.7.1 beta'

  def startup
    @start_up_window = StartupLoadingWindow.new VERSION
    @start_up_window.init_load_resources do
      yield
    end
  end

  def show_startup_error
    @start_up_window = StartupArgsErrorWindow.new VERSION
    @start_up_window.show
  end

  def init(user_id)
    autowired(NetworkService, UserService, CommunicationService)
    @user_service.init_user user_id
  end

  def run
    @network_service.connect(NetworkConfig::HOST_NAME, NetworkConfig::PORT)
    window = MainWindow.new VERSION
    window.show
  end
end