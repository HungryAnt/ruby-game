# coding: UTF-8

class MapItemControl < AntGui::Control
  def initialize(map_vm)
    super()
    @map_name = map_vm.name
    @map_id = map_vm.id
    autowired(WindowResourceService, MapUserCountService)
    @font_map_name = @window_resource_service.get_map_name_font
    @font_normal = @window_resource_service.get_normal_font
  end

  def do_draw(z)
    super
    color_0 = 0xFF_D0B848
    color_1 = 0xFF_E8D898
    left, top, width, height = @actual_left, @actual_top, @actual_width, @actual_height

    Gosu::draw_triangle(left, top, color_0, left, top + height, color_1, left + width, top + height, color_1, z)
    Gosu::draw_triangle(left, top, color_0, left + width, top + height, color_1, left + width, top, color_0, z)

    center_x = @actual_left + @actual_width / 2
    center_y = @actual_top + @actual_height / 2
    @font_map_name.draw_rel(@map_name, center_x, center_y, z, 0.5, 0.5, 1.0, 1.0, 0xFF_905810)

    user_count = @map_user_count_service.get_map_user_count(@map_id)

    @font_normal.draw_rel("#{user_count}人", left + width, top + height, z, 1.0, 1.0, 1.0, 1.0, 0xBB_000000)
  end
end

class VillageMapSelectionView
  ITEM_HEIGHT = 40
  ITEM_WIDTH = 250
  PADDING = 8
  MARGIN = 5

  attr_reader :visible

  def initialize(window)
    @window = window
    autowired(WindowResourceService)
    @visible = false
    @button_sound = @window_resource_service.get_sound_button
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

  def button_down(id)
    if id == Gosu::MsLeft
      return @map_selector_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
    end
    false
  end

  def on_select_map(&select_map_proc)
    @select_map_proc = select_map_proc
  end

  def update_maps(map_vms)
    init_map_selector map_vms
  end

  def mouse_move(mouse_x, mouse_y)
    @map_selector_dialog.mouse_move mouse_x, mouse_y
  end

  private

  def init_map_selector(map_vms)
    count = map_vms.length

    dialog_width = ITEM_WIDTH + PADDING * 2
    dialog_height = ITEM_HEIGHT * count + PADDING * 2 + MARGIN * (count - 1)
    dialog_left = (GameConfig::MAP_WIDTH - dialog_width) / 2
    dialog_top = (GameConfig::MAP_HEIGHT - dialog_height) / 2

    @map_selector_dialog = AntGui::Dialog.new dialog_left, dialog_top, dialog_width, dialog_height
    @map_selector_dialog.background_color = 0x88_000000
    canvas = AntGui::Canvas.new
    @map_selector_dialog.content = canvas

    x = PADDING
    y = PADDING
    map_vms.each do |map_vm|
      control = MapItemControl.new(map_vm)
      # control.background_color = 0xDE_D0B848
      AntGui::Canvas.set_canvas_props(control, x, y, ITEM_WIDTH, ITEM_HEIGHT)
      control.on_mouse_left_button_down do
        select_map map_vm.id.to_sym
      end
      control.on_mouse_enter do
        @button_sound.play
      end
      canvas.add control
      y += ITEM_HEIGHT + MARGIN
    end

    @map_selector_dialog.update_arrange
  end

  def select_map(map_id)
    @select_map_proc.call(map_id)
  end
end