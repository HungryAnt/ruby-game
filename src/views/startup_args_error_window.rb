# coding: UTF-8

class StartupArgsErrorWindow < Gosu::Window
  WINDOW_WIDTH = 500
  WINDOW_HEIGHT = 150

  def initialize(version)
    super WINDOW_WIDTH,
          WINDOW_HEIGHT, fullscreen:false, update_interval:1000/500
    self.caption = "童年记忆 - Ant版野菜部落 网络版 #{version}"
    @font = Gosu::Font.new(20)
  end

  def draw
    Gosu::draw_rect 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 0xFF_005020, ZOrder::Background

    @font.draw_rel('错误！请通过启动器启动游戏！', WINDOW_WIDTH/2, WINDOW_HEIGHT/2,
                   ZOrder::Background, 0.5, 0.5, 1.0, 1.0, 0xff_f0f0f0, :additive)
  end
end