class ActionsBarView
  PAGE_COUNT = 2
  PAGE_SIZE = 9

  class ActionItem
    attr_reader :action, :image
    def initialize(action, image)
      @action, @image = action, image
    end
  end

  class ActionItemControl < AntGui::Control
    def initialize(font, key_text)
      super()
      @font, @key_text = font, key_text
    end

    def do_draw(z)
      super
      GraphicsUtil.draw_text_with_border @key_text, @font, @actual_left + 1, @actual_top,
                                         z, 1.0, 1.0, 0xFF_FFFFFF, 0xFF_000000
      # @font.draw_rel(@key_text, @actual_left + 2, @actual_top + 2,
      #                z, 0, 0, 1.0, 1.0, 0xFF_FFFFFF)
    end
  end

  def initialize(window, game_map_view_model, ui_control_vm)
    autowired(WindowResourceService)
    @window = window
    @game_map_view_model = game_map_view_model
    @ui_control_vm = ui_control_vm
    @image_background = MediaUtil.get_img 'ui/actions_bar/FastActionInventory_6.bmp'
    init_actions
    init_controls
    init_keys
  end

  def update
    @dialog.mouse_move *get_mouse_location
  end

  def draw
    @image_background.draw(0, 0, ZOrder::UI, 1.0, 1.0)
    @dialog.draw ZOrder::UI
  end

  def button_down(id)
    if id == Gosu::MsLeft
      check_mouse_choose_action
      @dialog.mouse_left_button_down(*get_mouse_location)
      return true if @dialog.contains_point?(*get_mouse_location)
    end
    check_keyboard_choose_action id
  end

  def check_mouse_choose_action
    action = try_choose_action(*get_mouse_location)
    choose_action action
  end

  def check_keyboard_choose_action(id)
    action = choose_action_with_key_id id
    choose_action action
  end

  private
  def get_mouse_location
    left, top = *@ui_control_vm.actions_bar_location
    [@window.mouse_x - left, @window.mouse_y - top]
  end

  def try_choose_action(x, y)
    @action_button_infos.each do |info|
      button = info[:button]
      if button.contains_point? x, y
        return info[:action]
      end
    end
    nil
  end

  def choose_action_with_key_id(id)
    if @key_map.include? id
      index = @key_map[id]
      if index < @action_button_infos.size
        return @action_button_infos[index][:action]
      end
    end
    nil
  end

  def choose_action(action)
    if action.nil?
      false
    else
      @game_map_view_model.set_player_action action
      true
    end
  end

  def init_controls
    @key_text_font = @window_resource_service.get_font_13
    @action_button_infos = []

    @dialog = AntGui::Dialog.new(0, 0, GameConfig::ACTIONS_BAR_WIDTH, GameConfig::ACTIONS_BAR_HEIGHT)
    canvas = AntGui::Canvas.new
    @dialog.content = canvas

    x = 4
    y = 4
    item_width = item_height = 35
    action_items = get_actions
    0.upto(action_items.count - 1) do |i|
      item = action_items[i]
      action_button = ActionItemControl.new @key_text_font, (i+1).to_s
      action_image = AntGui::Image.new item.image
      action_button.content = action_image
      AntGui::Canvas.set_canvas_props action_button, x, y, item_width, item_height
      x += item_width + 4

      canvas.add action_button
      @action_button_infos << {
          button: action_button,
          action: item.action
      }
    end

    actions_up_button =
        @window_resource_service.create_button(356, 4, 20, 16,
                                               'ui/actions_bar/FastActionInventory_0.bmp',
                                               'ui/actions_bar/FastActionInventory_1.bmp') do
      prev_page
    end

    actions_down_button =
        @window_resource_service.create_button(356, 23, 20, 16,
                                               'ui/actions_bar/FastActionInventory_3.bmp',
                                               'ui/actions_bar/FastActionInventory_4.bmp') do
      next_page
    end

    canvas.add actions_up_button
    canvas.add actions_down_button

    @dialog.update_arrange
  end

  def init_keys
    @key_map = {
        Gosu::Kb1 => 0,
        Gosu::Kb2 => 1,
        Gosu::Kb3 => 2,
        Gosu::Kb4 => 3,
        Gosu::Kb5 => 4,
        Gosu::Kb6 => 5,
        Gosu::Kb7 => 6,
        Gosu::Kb8 => 7,
        Gosu::Kb9 => 8
    }
  end

  def init_actions
    @action_items = []
    add_action_item 0, Role::State::SCARE
    add_action_item 1, Role::State::LECHEROUS
    add_action_item 2, Role::State::BYE
    add_action_item 3, Role::State::CRY
    add_action_item 4, Role::State::LAUGH
    add_action_item 5, Role::State::FINGER_HIT
    add_action_item 6, Role::State::FART
    add_action_item 7, Role::State::HEAD_HIT
    add_action_item 8, Role::State::HIT
    @page_no = 0
  end

  def get_actions
    index_begin = @page_no * PAGE_SIZE
    index_end = index_begin + PAGE_SIZE
    @action_items[index_begin...index_end]
  end

  def prev_page
    @page_no = (@page_no + PAGE_COUNT - 1) % PAGE_COUNT
    init_controls
  end

  def next_page
    @page_no = (@page_no + 1) % PAGE_COUNT
    init_controls
  end

  def add_action_item(num, action=nil)
    @action_items << ActionItem.new(action, get_action_image(num))
  end

  def get_action_image(num)
    MediaUtil.get_img "ui/actions/ActionInventoryIcon_#{num}.bmp"
  end

  def create_button(left, top, width, height,
                    normal_image_path, hover_image_path)
    @window_resource_service.create_button left, top, width, height,
                                           normal_image_path, hover_image_path
  end
end