class Application
  VERSION = 'v0.8.0 beta'

  def validate_args
    return false if ARGV.size != 2
    return false if ARGV[0] !~ /^[a-zA-Z0-9_-]{36}$/
    return false if ARGV[1] !~ /^(window|fullscreen)$/
    true
  end

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

  def init(user_id, screen_mode)
    autowired(NetworkService, UserService, CommunicationService)
    @user_service.init_user user_id
    @screen_mode = screen_mode
  end

  def run
    @network_service.connect(NetworkConfig::HOST_NAME, NetworkConfig::PORT)
    window = MainWindow.new VERSION, @screen_mode
    window.show
  end
end