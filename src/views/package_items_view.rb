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

  def initialize(package_items_vm)
    @package_items_vm = package_items_vm
    @visible = false
  end

  def draw
    return unless @visible
    dialog_left, dialog_top = (GameConfig::WHOLE_WIDTH - DIALOG_WIDTH) / 2, (GameConfig::WHOLE_HEIGHT - DIALOG_HEIGHT) / 2
    Gosu::draw_rect(dialog_left, dialog_top, DIALOG_WIDTH, DIALOG_HEIGHT, 0x88_A17038, ZOrder::DIALOG_UI)

    items = @package_items_vm.get_items
    0.upto(ROW_COUNT * COL_COUNT - 1) do |index|
      row = index / COL_COUNT
      col = index % COL_COUNT
      item_left = dialog_left +  PADDING + (ITEM_WIDTH + MARGIN) * col
      item_top = dialog_top + PADDING + (ITEM_HEIGHT + MARGIN) * row
      Gosu::draw_rect(item_left, item_top, ITEM_WIDTH, ITEM_HEIGHT, 0xFF_2B2B2B, ZOrder::DIALOG_UI)

      if index < items.count
        item = items[index]
        item_img = EquipmentDefinition.get_item_image item.key
        item_img.draw(item_left, item_top, ZOrder::DIALOG_UI,
                      ITEM_WIDTH * 1.0 / item_img.width, ITEM_HEIGHT * 1.0 / item_img.height,
                      0xff_ffffff, mode = :default)
      end
    end
  end
end