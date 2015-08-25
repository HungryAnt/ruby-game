require_relative 'common/text_box'

class GameMapView < ViewBase

  def initialize(window)
    @window = window
    @game_map_view_model = GameMapViewModel.new
  end

  def init
    @game_map_view_model.init
    @status_bar_view = StatusBarView.new
    @chat_board_view = ChatBoardView.new(ChatBoardViewModel.new)
    @font_chat_input = Gosu::Font.new(18)
    @package_items_view = PackageItemsView.new(@game_map_view_model.package_items_view_model)
    init_chat_text_input
  end

  def update
    @game_map_view_model.update

    @status_bar_view.update
    @chat_board_view.update

    direction = Direction::NONE

    unless chat_input_enabled?
      if Gosu::button_down?(Gosu::KbUp) || Gosu::button_down?(Gosu::KbW)
        direction |= Direction::UP
      elsif Gosu::button_down?(Gosu::KbDown) || Gosu::button_down?(Gosu::KbS)
        direction |= Direction::DOWN
      end

      if Gosu::button_down?(Gosu::KbLeft) || Gosu::button_down?(Gosu::KbA)
        direction |= Direction::LEFT
      elsif Gosu::button_down?(Gosu::KbRight) || Gosu::button_down?(Gosu::KbD)
        direction |= Direction::RIGHT
      end
    end

    @game_map_view_model.player_move direction

    @game_map_view_model.update_mouse_type @window.mouse_x, @window.mouse_y
  end

  def draw
    @package_items_view.draw
    @game_map_view_model.draw
    @window.translate(0, GameConfig::STATUS_BAR_Y) do
      @status_bar_view.draw
      draw_chat_text_box
    end
    @window.translate(GameConfig::CHAT_BOARD_LEFT, GameConfig::CHAT_BOARD_TOP) do
      @chat_board_view.draw
    end
    @game_map_view_model.draw_mouse @window.mouse_x, @window.mouse_y
  end

  def draw_chat_text_box
    text_box_x = 60
    text_box_width = 333-60
    @chat_text_box.draw text_box_x, 30, text_box_width, 50-30
  end

  def button_down(id)
    return if chat_input_enabled? && id != Gosu::KbReturn && id != Gosu::KbBacktick

    case id
      when Gosu::Kb1
        @game_map_view_model.switch_map :grass_wood_back
      when Gosu::Kb2
        @game_map_view_model.switch_map :school
      when Gosu::Kb3
        @game_map_view_model.switch_map :church
      when Gosu::Kb4
        @game_map_view_model.switch_map :pay
      when Gosu::Kb5
        @game_map_view_model.switch_map :alipay
      when Gosu::KbF2
        @game_map_view_model.switch_map :police
      when Gosu::Kb0
        @game_map_view_model.switch_role_type RoleType::WAN_GYE
      when Gosu::Kb9
        @game_map_view_model.switch_role_type RoleType::SALARY
      when Gosu::MsLeft
        done = @game_map_view_model.try_pick_up(@window.mouse_x, @window.mouse_y)
        return if done
        @game_map_view_model.set_destination(@window.mouse_x, @window.mouse_y)
      # when Gosu::MsRight
      # when Gosu::KbE
      #   @player_view_model.start_eat_food
      when Gosu::KbF
        @game_map_view_model.discard
      when Gosu::KbQ
        @game_map_view_model.change_driving
      when Gosu::KbE
        @package_items_view.visible = !@package_items_view.visible
      when Gosu::KbReturn
        switch_chat_text_input
      when Gosu::KbBacktick
        if chat_input_enabled?
          switch_chat_text_input true
        end
    end
  end

  def init_chat_text_input
    @chat_text_box = TextBox.new(false)
    @window.text_input = nil
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
    end
    @window.text_input = chat_input_enabled? ? @chat_text_box.text_input : nil
  end

  def chat_input_enabled?
    @chat_text_box.enabled
  end



  def needs_cursor?
    @game_map_view_model.needs_cursor?
  end
end