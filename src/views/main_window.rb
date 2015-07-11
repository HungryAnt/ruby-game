# coding: UTF-8

class MainWindow < Gosu::Window

  def initialize
    super GameConfig::WIDTH, GameConfig::HEIGHT
    self.caption = '童年游戏-野菜部落'
    @game_map_view = GameMapView.new
    @map_editor_view = MapEditorView.new
    @current_view = @game_map_view
  end

  def update
    @current_view.update
  end

  def draw
    @current_view.draw
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
end

