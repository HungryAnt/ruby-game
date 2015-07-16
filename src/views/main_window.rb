# coding: UTF-8


# class Mouse
#   def initialize
#     @img = MediaUtil::get_img()
#   end
#
#   def draw x, y
#     @img.draw_rot x, y, ZOrder::Mouse, 0
#   end
# end

class MainWindow < Gosu::Window

  def initialize
    super GameConfig::MAP_WIDTH,
          GameConfig::MAP_HEIGHT + GameConfig::BOTTOM_HEIGHT
    self.caption = '童年游戏-野菜部落'
    @game_map_view = GameMapView.new(self)
    @map_editor_view = MapEditorView.new(self)
    @current_view = @game_map_view
    # @mouse = Mouse.new

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

    diff = Gosu::milliseconds - @begin_times
    update_rate = @update_times * 1000 / diff
    @font.draw("update_rate: #{update_rate} per second", 10, 30,
               ZOrder::UI, 1.0, 1.0, 0xff_ffff00)

    draw_rate = @draw_times * 1000 / diff
    @font.draw("draw_rate: #{draw_rate} per second", 10, 50,
               ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
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

