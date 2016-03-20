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

    # center_x = @actual_left + @actual_width / 2
    center_y = @actual_top + @actual_height / 2
    # @font_map_name.draw_rel(@map_name, center_x, center_y, z, 0.6, 0.5, 1.0, 1.0, 0xFF_905810)
    @font_map_name.draw_rel(@map_name, @actual_left + 20, center_y, z, 0.0, 0.5, 1.0, 1.0, 0xFF_905810)

    user_count = @map_user_count_service.get_map_user_count(@map_id)
    @font_normal.draw_rel("空雅数:#{user_count}  ",
                          left + width, top + height, z, 1.0, 1.0, 1.0, 1.0, 0xBB_000000)

    enemy_prompt_text = ''
    enemy_prompt_text << '大型垃圾 ' if @map_user_count_service.has_large_rubbish? @map_id
    enemy_prompt_text << '野怪 ' if @map_user_count_service.has_monster? @map_id

    unless enemy_prompt_text.nil?
      @font_normal.draw_rel(enemy_prompt_text + ' ',
                            left + width, top, z, 1.0, 0.0, 1.0, 1.0, 0xBB_EE0000)
    end
  end
end

class MapSelectionView
  ITEM_HEIGHT = 50
  ITEM_WIDTH = 270
  PADDING = 8
  MARGIN = 5
  HOR_MARGIN = 8

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
    use_tow_column = count > 5
    row_count = use_tow_column ? (count + 1) / 2 : count

    dialog_width = ITEM_WIDTH + PADDING * 2
    dialog_width += HOR_MARGIN + ITEM_WIDTH if use_tow_column

    dialog_height = ITEM_HEIGHT * row_count + PADDING * 2 + MARGIN * (row_count - 1)
    dialog_left = (GameConfig::MAP_WIDTH - dialog_width) / 2
    dialog_top = (GameConfig::MAP_HEIGHT - dialog_height) / 2

    @map_selector_dialog = AntGui::Dialog.new dialog_left, dialog_top, dialog_width, dialog_height
    @map_selector_dialog.background_color = 0x88_000000
    canvas = AntGui::Canvas.new
    @map_selector_dialog.content = canvas

    x = PADDING
    y = PADDING
    index = 0
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
      index += 1
      if index == row_count
        x += ITEM_WIDTH + HOR_MARGIN
        y = PADDING
      end
    end

    @map_selector_dialog.update_arrange
  end

  def select_map(map_id)
    @select_map_proc.call(map_id)
  end
end