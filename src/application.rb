class Application
  def initialize
    map = {}

    Kernel.send :define_method, :get_instance do |clazz|
      instance = map[clazz]
      if instance.nil?
        instance = clazz.new
        map[clazz] = instance
      end
      instance
    end

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