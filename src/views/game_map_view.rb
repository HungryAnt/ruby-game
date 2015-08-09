require_relative 'common/text_box'

class GameMapView < ViewBase

  def initialize(window)
    @window = window
    autowired(PlayerService, ChatService, MapService)
  end

  def init
    @player_service.init
    role = @player_service.role
    @player_view_model = PlayerViewModel.new(RoleViewModel.new(role))
    @gen_food_timestamp = Gosu::milliseconds
    @status_bar_view = StatusBarView.new
    @chat_board_view = ChatBoardView.new(ChatBoardViewModel.new)
    @map_service.switch_map :grass_wood_back
    @mouse_vm = MouseViewModel.new
    @font_chat_input = Gosu::Font.new(18)
    init_chat_text_input
  end

  def update
    @status_bar_view.update
    @chat_board_view.update

    @map_service.update_map

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

    @player_view_model.move direction, @map_service::current_map

    seconds = (Gosu::milliseconds - @gen_food_timestamp) / 1000
    gen_count = (seconds * GameConfig::FOOD_GEN_PER_SECOND).to_i
    if gen_count > 0
      @gen_food_timestamp += seconds * 1000

      food_vms = get_food_vms
      0.upto(gen_count - 1).each do
        # @food_view_models << Food.new(rand * GameConfig::MAP_WIDTH, rand * GameConfig::MAP_HEIGHT)
        food = FoodFactory.random_food(*@map_service::current_map.random_available_position)
        food_vms << FoodViewModel.new(food)
      end
    end

    # @player_view_model.collect_foods @food_view_models #.map {|food_mv| food_mv.food}

    @player_view_model.update

    check_mouse_action @window.mouse_x, @window.mouse_y
    goto_area
  end

  def draw
    @map_service.draw_map
    @player_view_model.draw
    get_food_vms.each { |food_vm| food_vm.draw }
    @window.translate(0, GameConfig::STATUS_BAR_Y) do
      @status_bar_view.draw
      draw_chat_text_box
    end
    @window.translate(GameConfig::CHAT_BOARD_LEFT, GameConfig::CHAT_BOARD_TOP) do
      @chat_board_view.draw
    end
    @mouse_vm.draw @window.mouse_x, @window.mouse_y
  end

  def draw_chat_text_box
    text_box_x = 60
    text_box_width = 333-60
    @chat_text_box.draw text_box_x, 30, text_box_width, 50-30
  end

  def button_down(id)
    return if chat_input_enabled? && id != Gosu::KbReturn

    case id
      when Gosu::Kb1
        @map_service.switch_map :grass_wood_back
      when Gosu::Kb2
        @map_service.switch_map :school
      when Gosu::Kb3
        @map_service.switch_map :church
      when Gosu::Kb0
        @player_view_model.role.role_type = RoleType::WAN_GYE
        @player_view_model.update_animations
      when Gosu::Kb9
        @player_view_model.role.role_type = RoleType::SALARY
        @player_view_model.update_animations
      when Gosu::MsLeft
        done = try_pick_up @window.mouse_x, @window.mouse_y
        return if done
        set_destination @window.mouse_x, @window.mouse_y
      # when Gosu::MsRight
      # when Gosu::KbE
      #   @player_view_model.start_eat_food
      when Gosu::KbF
        @player_view_model.discard get_food_vms
      when Gosu::KbReturn
        switch_chat_text_input
    end
  end

  def init_chat_text_input
    @chat_text_box = TextBox.new(false)
    @window.text_input = nil
  end

  def switch_chat_text_input
    if chat_input_enabled?
      text = @chat_text_box.text
      @chat_text_box.clear
      @chat_text_box.enabled = false

      # 发送聊天信息
      chat text
    else
      @chat_text_box.enabled = true
    end
    @window.text_input = chat_input_enabled? ? @chat_text_box.text_input : nil
  end

  def chat_input_enabled?
    @chat_text_box.enabled
  end

  def try_pick_up(mouse_x, mouse_y)
    item_vms = get_food_vms
    item_vm = get_touch_item mouse_x, mouse_y, item_vms
    return false if item_vm.nil?

    if item_vm.can_pick_up?(@player_view_model.role)
      @player_view_model.pick_up item_vms, item_vm
      true
    end

    set_destination mouse_x, mouse_y, item_vm

    true
  end

  def get_touch_item(mouse_x, mouse_y, food_vms)
    food_vms.each do |food_vm|
      return food_vm if food_vm.mouse_touch?(mouse_x, mouse_y)
    end
    nil
  end

  def touch_item?(mouse_x, mouse_y)
    item_vm = get_touch_item(mouse_x, mouse_y, get_food_vms)
    !item_vm.nil?
  end

  def goto_area()
    map_vm = get_current_map
    role = @player_view_model.role
    if map_vm.gateway? role.x, role.y
      @player_view_model.disable_auto_move
      map_vm.goto_area role
      @chat_service.sync_role(role, map_vm.current_area.id)
      return true
    end
    false
  end

  def check_mouse_action(mouse_x, mouse_y)
    map_vm = get_current_map
    mouse_left_down = Gosu::button_down?(Gosu::MsLeft)
    if map_vm.gateway? mouse_x, mouse_y
      @mouse_vm.set_mouse_type MouseType::GOTO_AREA
    elsif touch_item? mouse_x, mouse_y
      @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::PICK_UP_BUTTON_DOWN : MouseType::PICK_UP)
    else
      @mouse_vm.set_mouse_type(mouse_left_down ? MouseType::NORMAL_BUTTON_DOWN : MouseType::NORMAL)
    end
  end

  def set_destination(mouse_x, mouse_y, item_vm = nil)
    map_vm = get_current_map
    unless map_vm.tile_block? mouse_x, mouse_y
      map_vm.mark_target(mouse_x, mouse_y) unless map_vm.nil?
      @player_view_model.set_destination mouse_x, mouse_y, item_vm
    end
  end

  def needs_cursor?
    @mouse_vm.needs_cursor?
  end

  private
  def get_food_vms
    @map_service.current_map.current_area.food_vms
  end

  def get_current_map
    @map_service.current_map
  end

  def chat(msg)
    @chat_service.chat msg
  end
end