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

# class MyGuiState < Fidgit::GuiState
#   def initialize
#     super
#
#     # Create a vertically packed section, centred in the window.
#     vertical align: :center do
#       # Create a label with a dark green background.
#       my_label = label "Hello world!", background_color: Gosu::Color.rgb(0, 100, 0)
#
#       # Create a button that, when clicked, changes the label.
#       button("Goodbye", align_h: :center, tip: "Press me and be done with it!") do
#         my_label.text = "Goodbye cruel world!"
#       end
#     end
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

    if GameConfig::DEBUG
      diff = Gosu::milliseconds - @begin_times
      update_rate = @update_times * 1000 / diff
      @font.draw("update_rate: #{update_rate} per second", 10, 30,
                 ZOrder::UI, 1.0, 1.0, 0xff_ffff00)

      draw_rate = @draw_times * 1000 / diff
      @font.draw("draw_rate: #{draw_rate} per second", 10, 50,
                 ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    end
    Gosu::draw_rect 0, 0, 20 * 20, 20, 0xAA_EFEF56
    message = "v0.1 beta 作者:Gods_巨蚁 QQ:517377100"

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

