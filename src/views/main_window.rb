# coding: UTF-8

class MainWindow < Gosu::Window

  VERSION = 'v0.4.1 beta 网络版'

  def initialize
    super GameConfig::MAP_WIDTH,
          GameConfig::MAP_HEIGHT + GameConfig::BOTTOM_HEIGHT
    self.caption = "童年记忆 - Ant版野菜部落 网络版 #{VERSION}"
    @user_creation_view = UserCreationView.new(self)
    @game_map_view = GameMapView.new(self)
    @map_editor_view = MapEditorView.new(self)
    @current_view = @user_creation_view

    @user_creation_view.init_enter_game_proc do
      @game_map_view.init
      @current_view = @game_map_view
    end

    @begin_times = Gosu::milliseconds
    @update_times = 0
    @draw_times = 0
    @font = Gosu::Font.new(20)
  end

  def update
    @current_view.update
    @update_times += 1
  end

  def draw
    @current_view.draw
    @draw_times += 1

    if GameConfig::DEBUG
      diff = Gosu::milliseconds - @begin_times
      update_rate = @update_times * 1000 / diff
      @font.draw("update_rate: #{update_rate} per second", 10, 30,
                 ZOrder::UI, 1.0, 1.0, 0xff_ffff00)

      draw_rate = @draw_times * 1000 / diff
      @font.draw("draw_rate: #{draw_rate} per second", 10, 50,
                 ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    end
    Gosu::draw_rect 0, 0, 20 * 30, 20, 0xAA_EFEF56
    message = "#{VERSION} 作者:Gods_巨蚁 QQ:517377100 Q群:475143537"

    @font.draw(message, 11, 1,
               ZOrder::UI, 1.0, 1.0, 0xFF_9EC4FF)
    @font.draw(message, 10, 0,
               ZOrder::UI, 1.0, 1.0, 0xFF_2054A3)
  end

  def button_down(id)
    @current_view.button_down id

    case id
      when Gosu::KbF1
        @current_view = @game_map_view
      when Gosu::KbF2
        @current_view = @map_editor_view
    end
  end

  def button_up(id)
    @current_view.button_up id
  end

  def needs_cursor?
    @current_view.needs_cursor?
  end
end

