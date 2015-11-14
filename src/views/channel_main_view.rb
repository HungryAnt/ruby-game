# coding: UTF-8
require_relative 'channel_main/map_selection_view'

class ChannelMainView
  def initialize(window)
    autowired(WindowResourceService, SongService, MapService, MapUserCountService)
    @window = window
    init_channel_anims
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
    @map_selection_view = VillageMapSelectionView.new(window)
    @map_selection_view.on_select_map do |map_id|
      hide_map_selection_view
      goto_map map_id
    end
    @font_normal = @window_resource_service.get_normal_font
  end

  def on_shop(&shopping_call_back)
    @shopping_call_back = shopping_call_back
  end

  def show_map_selection_view(*map_ids)
    map_vms = map_ids.map {|map_id| @map_service.get_map map_id}
    @map_selection_view.update_maps map_vms
    @map_selection_view.show
    @main_dialog.active = false
  end

  def hide_map_selection_view
    @map_selection_view.hide
    @main_dialog.active = true
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def init_channel_anims
    @anim_container = AnimationContainer.new
    create_anim :channel_main_vegetable, 340, 320, ZOrder::DIALOG_UI
    create_anim :channel_main_cows, 200, 276, ZOrder::DIALOG_UI
    create_anim :channel_main_sky_wheel, 620, 50
    create_anim :channel_main_waterfall, 110, 150, ZOrder::DIALOG_UI
  end

  def create_anim(key, x, y, z=ZOrder::Background)
    anim = AnimationManager::get_anim key
    anim_holder = AnimationHolder.new(anim, x, y, z)
    @anim_container << anim_holder
  end

  def init_channel_element
    @main_dialog = AntGui::Dialog.new(0, 0, GameConfig::MAP_WIDTH, GameConfig::MAP_HEIGHT)
    canvas = AntGui::Canvas.new
    @main_dialog.content = canvas
    @sample_instances = []

    control_rubbish_station = create_channel_control(canvas, 7, 8, 276, 160, 138, 125,
                                                     28, 5, 5, 5, :rubbish_station)
    control_rubbish_station.on_mouse_left_button_down do
      goto_map :waste_station
    end

    control_seven_star_hall = create_channel_control(canvas, 11, 12, 120, 50, 221, 238,
                                                     35, 31, 31, 5, :seven_star_hall, ZOrder::DIALOG_UI)
    control_seven_star_hall.on_mouse_left_button_down do
      goto_map :seven_star_hall
    end

    control_village = create_channel_control(canvas, 1, 2, 0, 228, 370, 251,
                                             0, 59, 150, 29, :village, ZOrder::DIALOG_UI)
    control_village.on_mouse_left_button_down do
      # goto_map :house
      show_map_selection_view(:my_room, :grass_wood_back, :school, :church, :house, :cart,
                              :ghost_house, :henhouse, :rainy_day, :sled, :market)
    end

    control_police_station = create_channel_control(canvas, 13, 14, 430, 160, 103, 79,
                                                    0, 0, 0, 0, :police_station)
    control_police_station.on_mouse_left_button_down do
      goto_map :police
    end

    control_playground = create_channel_control(canvas, 3, 4, 430, 100, 370, 229,
                                                86, 50, 0, 44, :playground)
    control_playground.on_mouse_left_button_down do
      # 修建中
    end

    control_shop = create_channel_control(canvas, 5, 6, 334, 260, 372, 180,
                                          125, 28, 46, 22, :shop)
    control_shop.on_mouse_left_button_down do
      # show_map_selection_view :pay, :alipay
      @shopping_call_back.call unless @shopping_call_back.nil?
    end

    exit_button = AntGui::Facade.create_image_button(get_button_image_path(0), get_button_image_path(1))
    exit_button.on_mouse_left_button_down {@exit_call_back.call}
    exit_button.z_order = ZOrder::DIALOG_UI
    AntGui::Canvas.set_canvas_props(exit_button, 630, 486, 170, 114)
    canvas.add exit_button

    @main_dialog.update_arrange
  end

  def goto_map(map_id)
    @map_selection_view.hide
    pause_all_sample_instances
    @select_map_call_back.call map_id
  end

  def create_channel_control(canvas, normal_image_num, hover_image_num, left, top, width, height,
                             margin_left=0, margin_top=0, margin_right=0, margin_bottom=0, music_key=nil,
                             z_order=ZOrder::Background)
    image_back = AntGui::Image.new(MediaUtil.get_img(get_image_path(normal_image_num)))
    image_active = AntGui::Image.new(MediaUtil.get_img(get_image_path(hover_image_num)))
    image_active.z_order = z_order
    AntGui::Canvas.set_canvas_props(image_back, left, top, width, height)
    AntGui::Canvas.set_canvas_props(image_active, left, top, width, height)
    canvas.add image_back
    canvas.add image_active
    image_back.visible = true
    image_active.visible = false

    control = AntGui::Control.new
    AntGui::Canvas.set_canvas_props(control, left + margin_left, top + margin_top,
                                    width - margin_left - margin_right, height - margin_top - margin_bottom)

    music_sample_instance = nil
    unless music_key.nil?
      music = @window_resource_service.get_channel(music_key)
      music_sample_instance = music.play 1, 1, true
      music_sample_instance.pause
      @sample_instances << music_sample_instance
    end

    control.on_mouse_enter do
      # image_back.visible = false
      image_active.visible = true
      music_sample_instance.resume unless music_sample_instance.nil?
    end
    control.on_mouse_leave do
      # image_back.visible = true
      image_active.visible = false
      music_sample_instance.pause unless music_sample_instance.nil?
    end
    canvas.add control
    control
  end

  def get_image_path(num)
    "channel_main/ChannelMain_#{num}.bmp"
  end

  def get_button_image_path(num)
    "channel_main/button/ChannelButton_#{num}.bmp"
  end

  def register_select_map(&call_back)
    @select_map_call_back = call_back
  end

  def update
    @main_dialog.mouse_move(@window.mouse_x, @window.mouse_y)
    @map_selection_view.mouse_move(@window.mouse_x, @window.mouse_y) if @map_selection_view.visible
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @anim_container.draw
    @main_dialog.draw ZOrder::Background

    draw_bottom_bar

    @map_selection_view.draw
  end

  def draw_bottom_bar
    left, top, width, height = 0, GameConfig::MAP_HEIGHT, GameConfig::MAP_WIDTH, GameConfig::WHOLE_HEIGHT - GameConfig::MAP_HEIGHT
    GraphicsUtil.draw_linear_rect(left, top, width, height, ZOrder::Background, 0xFF_FEFEFE, 0xFF_DBDBDB)

    user_count = @map_user_count_service.get_all_user_count
    @font_normal.draw_rel("总在线空雅数:#{user_count}", left + 5, top + height / 2, ZOrder::DIALOG_UI,
                          0, 0.5, 1.0, 1.0, 0xBB_000000)
  end

  def button_down(id)
    r = @map_selection_view.button_down(id) if @map_selection_view.visible
    return if r

    case id
      when Gosu::MsLeft
        if @map_selection_view.visible
          hide_map_selection_view
        else
          @main_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
        end
    end
  end

  def button_up(id)

  end

  def needs_cursor?
    true
  end

  def active
    @song_service.play_song 'channel/back.ogg'
  end

  def pause_all_sample_instances
    @sample_instances.each {|sample_instance| sample_instance.pause}
  end
end