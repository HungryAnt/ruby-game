# coding: UTF-8

class PackageItemsView
  attr_accessor :visible

  ROW_COUNT = 5
  COL_COUNT = 6

  PROMPT_HEIGHT = 30
  ITEM_WIDTH = 50
  ITEM_HEIGHT = 50
  MARGIN = 5
  PADDING = 10

  def initialize(window, package_items_vm)
    autowired(WindowResourceService)
    @window = window
    @package_items_vm = package_items_vm
    @visible = false
    @prompt_font = @window_resource_service.get_normal_font
    init_controls
  end

  def init_controls
    dialog_width = ITEM_WIDTH * COL_COUNT + MARGIN * (COL_COUNT - 1) + PADDING * 2
    dialog_height = PROMPT_HEIGHT + MARGIN + ITEM_HEIGHT * ROW_COUNT + MARGIN * (ROW_COUNT - 1) + PADDING * 2

    dialog_left, dialog_top = (GameConfig::WHOLE_WIDTH - dialog_width) / 2, (GameConfig::WHOLE_HEIGHT - dialog_width) / 2
    @dialog = AntGui::Dialog.new(dialog_left, dialog_top, dialog_width, dialog_height)
    @dialog.background_color = 0x88_A17038
    canvas = AntGui::Canvas.new
    @dialog.content = canvas

    prompt_text_block = AntGui::TextBlock.new(@prompt_font, '点击切换载具，Q键上下车')
    prompt_text_block.background_color = 0x88_FFFFFF
    canvas.add prompt_text_block
    AntGui::Canvas.set_canvas_props(prompt_text_block, PADDING, PADDING, dialog_width - PADDING * 2, PROMPT_HEIGHT)

    items = @package_items_vm.get_items
    0.upto(ROW_COUNT * COL_COUNT - 1) do |index|
      row = index / COL_COUNT
      col = index % COL_COUNT
      item_left = PADDING + (ITEM_WIDTH + MARGIN) * col
      item_top = PADDING + (ITEM_HEIGHT + MARGIN) * row + PROMPT_HEIGHT + MARGIN
      control = AntGui::Control.new
      control.set(AntGui::Canvas::LEFT, item_left)
      control.set(AntGui::Canvas::TOP, item_top)
      control.set(AntGui::Canvas::WIDTH, ITEM_WIDTH)
      control.set(AntGui::Canvas::HEIGHT, ITEM_HEIGHT)
      control.background_color = 0xFF_2B2B2B

      if index < items.count
        item = items[index]
        item_img = EquipmentDefinition.get_item_image item.key
        image = AntGui::Image.new(item_img)
        control.content = image
        control.on_mouse_left_button_down do
          @package_items_vm.choose_equipment item
          @visible = false
        end
      end

      canvas.add(control)
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
        else
          @visible = false
        end
        return true
    end
    false
  end
end