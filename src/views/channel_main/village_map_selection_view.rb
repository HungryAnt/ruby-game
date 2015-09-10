class MapItemControl < AntGui::Control
  def initialize(map_vm)
    super()
    @map_name = map_vm.name
    autowired(WindowResourceService)
    @font_map_name = @window_resource_service.get_map_name_font
  end

  def do_draw(z)
    super
    center_x = @actual_left + @actual_width / 2
    center_y = @actual_top + @actual_height / 2
    @font_map_name.draw_rel(@map_name, center_x, center_y, z, 0.5, 0.5, 1.0, 1.0, 0xff_f0f0f0, :additive)
  end
end

class VillageMapSelectionView
  ITEM_HEIGHT = 40
  ITEM_WIDTH = 250
  PADDING = 10
  MARGIN = 5

  def initialize(window)
    @window = window
    autowired(MapService)
    @visible = true
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

    x = PADDING
    y = PADDING
    all_maps.each do |map_vm|
      map_vm.id
      control = MapItemControl.new(map_vm)
      control.background_color = 0xFF_558899
      AntGui::Canvas.set_canvas_props(control, x, y, ITEM_WIDTH, ITEM_HEIGHT)
      canvas.add control
      y += ITEM_HEIGHT + MARGIN
    end

    @map_selector_dialog.update_arrange
  end

  def button_down(id)
    if id == Gosu::MsLeft
      return @map_selector_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
    end
    false
  end
end