class Application
  def initialize
    [UserService, ChatService].each do |clazz|
      get_instance(clazz)
    end
  end

  def init

  end

  def run
    window = MainWindow.new
    window.show
  end
end