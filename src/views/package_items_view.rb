class PackageItemsView
  attr_accessor :visible

  ROW_COUNT = 8
  COL_COUNT = 10

  DIALOG_WIDTH = 565
  DIALOG_HEIGHT = 455
  ITEM_WIDTH = 50
  ITEM_HEIGHT = 50
  MARGIN = 5
  PADDING = 10

  def initialize(window, package_items_vm)
    @window = window
    @package_items_vm = package_items_vm
    @visible = false
    init_controls
  end

  def init_controls
    dialog_left, dialog_top = (GameConfig::WHOLE_WIDTH - DIALOG_WIDTH) / 2, (GameConfig::WHOLE_HEIGHT - DIALOG_HEIGHT) / 2
    @dialog = AntGui::Dialog.new(dialog_left, dialog_top, DIALOG_WIDTH, DIALOG_HEIGHT)
    @dialog.background_color = 0x88_A17038
    @canvas = AntGui::Canvas.new
    @dialog.content = @canvas

    # Gosu::draw_rect(dialog_left, dialog_top, DIALOG_WIDTH, DIALOG_HEIGHT, 0x88_A17038, ZOrder::DIALOG_UI)

    items = @package_items_vm.get_items
    0.upto(ROW_COUNT * COL_COUNT - 1) do |index|
      row = index / COL_COUNT
      col = index % COL_COUNT
      item_left = dialog_left +  PADDING + (ITEM_WIDTH + MARGIN) * col
      item_top = dialog_top + PADDING + (ITEM_HEIGHT + MARGIN) * row
      control = AntGui::Control.new
      control.set(AntGui::Canvas::LEFT, item_left)
      control.set(AntGui::Canvas::TOP, item_top)
      control.set(AntGui::Canvas::WIDTH, ITEM_WIDTH)
      control.set(AntGui::Canvas::HEIGHT, ITEM_HEIGHT)
      control.background_color = 0xFF_2B2B2B
      # Gosu::draw_rect(item_left, item_top, ITEM_WIDTH, ITEM_HEIGHT, 0xFF_2B2B2B, ZOrder::DIALOG_UI)

      if index < items.count
        item = items[index]
        item_img = EquipmentDefinition.get_item_image item.key
        # item_img.draw(item_left, item_top, ZOrder::DIALOG_UI,
        #               ITEM_WIDTH * 1.0 / item_img.width, ITEM_HEIGHT * 1.0 / item_img.height,
        #               0xff_ffffff, mode = :default)
        image = AntGui::Image.new(item_img)
        control.content = image
        control.on_mouse_left_button_down do
          @package_items_vm.choose_equipment item
        end
      end

      @canvas.add(control)
    end

    @dialog.update_arrange
  end

  def draw
    return unless @visible
    @dialog.draw
  end

  def button_down(id)
    return false unless @visible
    case id
      when Gosu::MsLeft, Gosu::MsRight
        mouse_x, mouse_y = @window.mouse_x, @window.mouse_y
        if @dialog.contains_point?(mouse_x, mouse_y)
          if id == Gosu::MsLeft
            @dialog.mouse_left_button_down(mouse_x, mouse_y)
          else
            # @dialog.mouse_right_button_down(mouse_x, mouse_y)
          end
          return true
        end
    end
    false
  end
end