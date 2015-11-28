# coding: UTF-8

class StartupLoadingWindow < Gosu::Window
  WINDOW_WIDTH = 500
  WINDOW_HEIGHT = 150

  def initialize(version)
    super WINDOW_WIDTH,
          WINDOW_HEIGHT, fullscreen:false, update_interval:1000/500
    self.caption = "童年记忆 - Ant版野菜部落 网络版 #{version}"
    @font = Gosu::Font.new(20)
    @load_proc = nil
    @update_times = 0
  end

  def init_load_resources(&load_proc)
    @load_proc = load_proc
    show
  end

  def update
    if @update_times == 1
      @load_proc.call
      close
    end
    @update_times += 1
  end

  def draw
    Gosu::draw_rect 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 0xFF_005020, ZOrder::Background

    @font.draw_rel('加载游戏资源数据中，所需时间较长，请耐心等待...', WINDOW_WIDTH/2, WINDOW_HEIGHT/2,
                   ZOrder::Background, 0.5, 0.5, 1.0, 1.0, 0xff_f0f0f0, :additive)
  end
end