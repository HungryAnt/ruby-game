require_relative 'common/text_box'

class GameMapView < ViewBase

  def initialize(window)
    autowired(WindowResourceService)
    @window = window
    @game_map_view_model = GameMapViewModel.new
  end

  def init
    @game_map_view_model.init
    @status_bar_view = StatusBarView.new
    @chat_board_view = ChatBoardView.new(ChatBoardViewModel.new)
    @ui_control_vm = UiControlViewModel.new
    @actions_bar_view = ActionsBarView.new(@window, @game_map_view_model, @ui_control_vm)
    @font_chat_input = Gosu::Font.new(18)
    @package_items_view = PackageItemsView.new(@window, @game_map_view_model.package_items_view_model)
    init_chat_text_input
    init_controls
    init_buttons
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def init_switch_map(map_id)
    @game_map_view_model.switch_map map_id
  end

  def quit_map
    @game_map_view_model.quit_map
  end

  def update
    @game_map_view_model.update

    @status_bar_view.update
    @chat_board_view.update

    # direction = Direction::NONE
    #
    # unless chat_input_enabled?
    #   if Gosu::button_down?(Gosu::KbUp) || Gosu::button_down?(Gosu::KbW)
    #     direction |= Direction::UP
    #   elsif Gosu::button_down?(Gosu::KbDown) || Gosu::button_down?(Gosu::KbS)
    #     direction |= Direction::DOWN
    #   end
    #
    #   if Gosu::button_down?(Gosu::KbLeft) || Gosu::button_down?(Gosu::KbA)
    #     direction |= Direction::LEFT
    #   elsif Gosu::button_down?(Gosu::KbRight) || Gosu::button_down?(Gosu::KbD)
    #     direction |= Direction::RIGHT
    #   end
    # end
    #
    # @game_map_view_model.player_move direction

    @game_map_view_model.update_mouse_type @window.mouse_x, @window.mouse_y
    @status_dialog.mouse_move @window.mouse_x, @window.mouse_y

    @actions_bar_view.update
  end

  def draw
    @package_items_view.draw
    @game_map_view_model.draw
    @window.translate(0, GameConfig::STATUS_BAR_Y) do
      @status_bar_view.draw
      draw_chat_text_box
    end

    if @ui_control_vm.chat_board_visible
      @window.translate(*@ui_control_vm.chat_board_location) do
        @chat_board_view.draw
      end
    end

    if @ui_control_vm.actions_bar_visible
      @window.translate(*@ui_control_vm.actions_bar_location) do
        @actions_bar_view.draw
      end
    end

    @game_map_view_model.draw_mouse @window.mouse_x, @window.mouse_y
    @status_dialog.draw
  end

  def draw_chat_text_box
    text_box_x = 60
    text_box_width = 333-60
    @chat_text_box.draw text_box_x, 30, text_box_width, 50-30
  end

  def button_down(id)
    if @ui_control_vm.actions_bar_visible
      return if @actions_bar_view.button_down(id)
    end

    if id == Gosu::MsLeft
      return if @status_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
    end

    return if chat_input_enabled? && id != Gosu::KbReturn && id != Gosu::KbBacktick
    return if @package_items_view.button_down(id)

    case id
      when Gosu::MsLeft
        @game_map_view_model.stop_smash
        done = @game_map_view_model.try_pick_up(@window.mouse_x, @window.mouse_y)
        return if done
        done = @game_map_view_model.try_smash_rubbish(@window.mouse_x, @window.mouse_y)
        return if done
        @game_map_view_model.set_destination(@window.mouse_x, @window.mouse_y)
      when Gosu::KbF
        @game_map_view_model.discard
      when Gosu::KbQ
        @game_map_view_model.change_driving
      when Gosu::KbE
        @package_items_view.visible = !@package_items_view.visible
        @package_items_view.init_controls if @package_items_view.visible
      when Gosu::KbReturn
        switch_chat_text_input
      when Gosu::KbBacktick
        if chat_input_enabled?
          switch_chat_text_input true
        end
      when Gosu::KbA
        @game_map_view_model.hit
    end
  end

  def init_chat_text_input
    @chat_text_box = TextBox.new(false)
    @window.text_input = nil
    @sound_textbox = MediaUtil::get_sample('textbox.wav')
  end

  def switch_chat_text_input(is_cmd = false)
    if chat_input_enabled?
      text = @chat_text_box.text
      @chat_text_box.clear
      @chat_text_box.enabled = false

      if is_cmd
        # 发送命令消息
        @game_map_view_model.command text if text.size > 0
      else
        # 发送聊天消息
        @game_map_view_model.chat text if text.size > 0
      end
    else
      @chat_text_box.enabled = true
      @sound_textbox.play
    end
    @window.text_input = chat_input_enabled? ? @chat_text_box.text_input : nil
  end

  def chat_input_enabled?
    @chat_text_box.enabled
  end

  def needs_cursor?
    @game_map_view_model.needs_cursor?
  end

  def init_controls


  end

  def init_buttons
    @status_dialog = AntGui::Dialog.new(0, 0, GameConfig::STATUS_BAR_WIDTH, GameConfig::STATUS_BAR_HEIGHT)
    canvas = AntGui::Canvas.new
    @status_dialog.content = canvas
    exit_button = create_button(727, GameConfig::STATUS_BAR_Y + 27, 35, 26,
                                'ui/button/GameViewButton_24.bmp',
                                'ui/button/GameViewButton_25.bmp') do
      @exit_call_back.call unless @exit_call_back.nil?
      quit_map
    end

    actions_bar_checkbox = create_button(353, GameConfig::STATUS_BAR_Y + 31, 17, 17,
                                         'ui/button/GameViewButton_6.bmp',
                                         'ui/button/GameViewButton_7.bmp') do
      @ui_control_vm.switch_actions_bar_visible
    end

    chat_board_checkbox = create_button(372, GameConfig::STATUS_BAR_Y + 31, 17, 17,
                                        'ui/button/GameViewButton_9.bmp',
                                        'ui/button/GameViewButton_10.bmp') do
      @ui_control_vm.switch_chat_board_visible
    end



    canvas.add exit_button
    canvas.add actions_bar_checkbox
    canvas.add chat_board_checkbox
    @status_dialog.update_arrange
  end

  def create_button(left, top, width, height,
                    normal_image_path, hover_image_path, &proc)
    @window_resource_service.create_button left, top, width, height,
                                           normal_image_path, hover_image_path, &proc
  end
end