class ActionsBarView
  class ActionItem
    attr_reader :action, :image
    def initialize(action, image)
      @action, @image = action, image
    end
  end

  def initialize
    @image_background = MediaUtil.get_img 'ui/actions_bar/FastActionInventory_6.bmp'
    init_actions
    init_controls
  end

  def init_controls
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
      action_button = AntGui::Control.new
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