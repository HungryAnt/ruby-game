class MapItem < AntGui::Control
  def initialize
    super
  end

  def draw

  end
end

class VillageMapSelectionView
  ITEM_HEIGHT = 20
  ITEM_WIDTH = 100
  PADDING = 10
  MARGIN = 5

  def initialize
    autowired(MapService)
    @visible = false
    init_map_selector
  end

  def show
    @visible = true
  end

  def hide
    @visible = false
  end

  def draw
    return unless @visible
    @map_selector_dialog.draw
  end

  def init_map_selector
    all_maps = @map_service.all_maps
    count = all_maps.length

    dialog_width = ITEM_WIDTH + PADDING * 2
    dialog_height = ITEM_HEIGHT * count + PADDING * 2 + MARGIN * (count - 1)
    dialog_left = (GameConfig::MAP_WIDTH - dialog_width) / 2
    dialog_top = (GameConfig::MAP_HEIGHT - dialog_height) / 2

    @map_selector_dialog = AntGui::Dialog.new dialog_left, dialog_top, dialog_width, dialog_height
    @map_selector_dialog.background_color = 0xFF_FFFF00
    canvas = AntGui::Canvas.new
    @map_selector_dialog.content = canvas

    x = dialog_left + PADDING
    y = dialog_top + PADDING
    all_maps.each do |map_vm|
      map_vm.id
      control = AntGui::Control.new
      control.background_color = 0xFF_558899
      AntGui::Canvas.set_canvas_props(control, x, y, ITEM_WIDTH, ITEM_HEIGHT)
      canvas.add control
      y += ITEM_HEIGHT + MARGIN
    end

    @map_selector_dialog.update_arrange
  end
end