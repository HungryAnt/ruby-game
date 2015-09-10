# coding: UTF-8
require_relative 'channel_main/village_map_selection_view'

class ChannelMainView
  def initialize(window)
    autowired(WindowResourceService, SongService)
    @window = window
    init_channel_anims
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
    # @target_map_id = nil
    @village_map_selection_view = VillageMapSelectionView.new(window)
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def init_channel_anims
    @anim_container = AnimationContainer.new
    create_anim :channel_main_vegetable, 340, 320, ZOrder::DIALOG_UI
    create_anim :channel_main_cows, 200, 276
    create_anim :channel_main_sky_wheel, 620, 50
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
      # 修建中
    end

    control_seven_star_hall = create_channel_control(canvas, 11, 12, 120, 50, 221, 238,
                                                     35, 31, 31, 5, :seven_star_hall)
    control_seven_star_hall.on_mouse_left_button_down do
      goto_map :seven_star_hall
    end

    control_village = create_channel_control(canvas, 1, 2, 0, 228, 370, 251,
                                             0, 59, 150, 29, :village)
    control_village.on_mouse_left_button_down do
      goto_map :house
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
      goto_map :pay
    end

    exit_button = AntGui::Facade.create_image_button(get_button_image_path(0), get_button_image_path(1))
    exit_button.on_mouse_left_button_down {@exit_call_back.call}
    exit_button.z_order = ZOrder::DIALOG_UI
    AntGui::Canvas.set_canvas_props(exit_button, 630, 486, 170, 114)
    canvas.add exit_button

    @main_dialog.update_arrange
  end

  def goto_map(map_id)
    pause_all_sample_instances
    @select_map_call_back.call map_id
  end

  def create_channel_control(canvas, normal_image_num, hover_image_num, left, top, width, height,
                             margin_left=0, margin_top=0, margin_right=0, margin_bottom=0, music_key=nil)
    image_back = AntGui::Image.new(MediaUtil.get_img(get_image_path(normal_image_num)))
    image_active = AntGui::Image.new(MediaUtil.get_img(get_image_path(hover_image_num)))
    # image_back.z_order = image_active.z_order = z_order
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
      music_sample_instance.resume unless music.nil?
    end
    control.on_mouse_leave do
      # image_back.visible = true
      image_active.visible = false
      music_sample_instance.pause unless music.nil?
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
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @anim_container.draw
    @main_dialog.draw ZOrder::Background

    left, top, width, height = 0, GameConfig::MAP_HEIGHT, GameConfig::MAP_WIDTH, GameConfig::WHOLE_HEIGHT - GameConfig::MAP_HEIGHT
    color_0 = 0xFF_FEFEFE
    color_1 = 0xFF_DBDBDB
    Gosu::draw_triangle(left, top, color_0, left, top + height, color_1, left + width, top + height, color_1,
                        ZOrder::Background)
    Gosu::draw_triangle(left, top, color_0, left + width, top + height, color_1, left + width, top, color_0,
                        ZOrder::Background)

    @village_map_selection_view.draw
  end

  def button_down(id)
    return if @village_map_selection_view.button_down id

    case id
      when Gosu::MsLeft
        @main_dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
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