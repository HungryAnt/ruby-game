class ActionsBarView
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

  def initialize
    autowired(WindowResourceService)
    @image_background = MediaUtil.get_img 'ui/actions_bar/FastActionInventory_6.bmp'
    init_actions
    init_controls
    init_keys
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
    items_count = 9
    0.upto(items_count - 1) do |i|
      item = @action_items[i]
      action_button = ActionItemControl.new @key_text_font, (i+1).to_s
      action_image = AntGui::Image.new item.image
      action_button.content = action_image
      AntGui::Canvas.set_canvas_props action_button, x, y, item_width, item_height

      # item.image.draw(x, y, ZOrder::UI, 1.0, 1.0,
      #                 0xff_ffffff, mode = :default)
      x += item_width + 4

      canvas.add action_button
      @action_button_infos << {
          button: action_button,
          action: item.action
      }
    end

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

  def draw
    @image_background.draw(0, 0, ZOrder::UI, 1.0, 1.0)
    @dialog.draw ZOrder::UI
    # x = 4
    # y = 4
    # items_count = 9
    # 0.upto(items_count - 1) do |i|
    #   item = @action_items[i]
    #   item.image.draw(x, y, ZOrder::UI, 1.0, 1.0,
    #                   0xff_ffffff, mode = :default)
    #   x += 35 + 4
    # end
  end

  def choose_action(x, y)
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

  private
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
  end

  def add_action_item(num, action=nil)
    @action_items << ActionItem.new(action, get_action_image(num))
  end

  def get_action_image(num)
    MediaUtil.get_img "ui/actions/ActionInventoryIcon_#{num}.bmp"
  end

end