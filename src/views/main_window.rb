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
          GameConfig::STATUS_BAR_Y + GameConfig::STATUS_BAR_HEIGHT
    self.caption = '童年游戏-野菜部落'
    @game_map_view = GameMapView.new(self)
    @map_editor_view = MapEditorView.new
    @current_view = @game_map_view
    # @mouse = Mouse.new
  end

  def update
    @current_view.update
  end

  def draw
    @current_view.draw
    # @mouse.draw mouse_x, mouse_y
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

  def needs_cursor?
    @current_view.needs_cursor?
  end
end

