# coding: UTF-8
require_relative 'channel_main/map_selection_view'

class ChannelMainView
  def initialize(window)
    autowired(WindowResourceService, SongService, MapService, MapUserCountService, PlayerService)
    @window = window
    @font_normal = @window_resource_service.get_normal_font
    init_channel_anims
    init_channel_element
    @background_image = MediaUtil::get_tileable_img('channel_main/ChannelMain_0.bmp')
    @select_map_call_back = nil
    @map_selection_view = MapSelectionView.new(window)
    @map_selection_view.on_select_map do |map_id|
      # if map_id == :circus && @player_service.role.lv < 0
      #   MessageBox.info '先达到100级，再来这个地图吧', MessageBox::BoxType::BOX_OK
      # elsif map_id == :dota
      #   MessageBox.info '开发ing，下个版本见', MessageBox::BoxType::BOX_OK
      # else
        hide_map_selection_view
        goto_map map_id
      # end
    end
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
    @main_dialog = AntGui::Dialog.new(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT)
    canvas = AntGui::Canvas.new
    @main_dialog.content = canvas
    @sample_instances = []

    control_hunting_ground = create_anim_channel_control(canvas, 0, 28, 158, 135)
    control_hunting_ground.on_mouse_left_button_down do
      show_map_selection_view :vegetable_field, :colliery, :hunting, :circus, :dota
    end

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
                              :ghost_house, :henhouse, :rainy_day, :sled, :market,
                              :snow_village, :river_side, :port, :pool, :xiujuan_house,
                              :universe1, :universe2, :custom1, :picnic)
    end

    control_police_station = create_channel_control(canvas, 13, 14, 430, 160, 103, 79,
                                                    0, 0, 0, 0, :police_station)
    control_police_station.on_mouse_left_button_down do
      goto_map :police
    end

    control_playground = create_channel_control(canvas, 3, 4, 430, 100, 370, 229,
                                                86, 50, 0, 44, :playground)
    control_playground.on_mouse_left_button_down do
      show_map_selection_view(:amusement_park, :chess)
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

    is_background_sound_on = true
    background_sound_button = create_button(168, GameConfig::MAP_HEIGHT + 5,
                                            150, GameConfig::BOTTOM_HEIGHT - 10,
                                            '开启/关闭背景音乐') do
      is_background_sound_on = !is_background_sound_on
      if is_background_sound_on
        @song_service.turn_on
        turn_on_samples
      else
        @song_service.turn_off
        turn_off_samples
      end
    end

    is_music_sample_on = true
    music_sample_button = create_button(350, GameConfig::MAP_HEIGHT + 5,
                                        128, GameConfig::BOTTOM_HEIGHT - 10,
                                        '开启/关闭音效') do
      is_music_sample_on = !is_music_sample_on
      if is_music_sample_on
        MusicSample.turn_on
      else
        MusicSample.turn_off
      end
    end

    canvas.add background_sound_button
    canvas.add music_sample_button
    @main_dialog.update_arrange
  end

  def create_button(left, top, width, height, text, &mouse_left_button_down_action)
    button = AntGui::TextBlock.new(@font_normal, text, :center)
    button.z_order = ZOrder::DIALOG_UI
    button.background_color = 0xFF_D0B848
    AntGui::Canvas.set_canvas_props(button, left, top, width, height)
    button.on_mouse_left_button_down &mouse_left_button_down_action
    button
  end

  def goto_map(map_id)
    @map_selection_view.hide
    pause_all_sample_instances
    @select_map_call_back.call map_id
  end

  def create_anim_channel_control(canvas, left, top, width, height,
                                  margin_left=0, margin_top=0, margin_right=0, margin_bottom=0)
    anim_back = AntGui::Animation.new(AnimationManager.get_anim :channel_hunting_ground_normal)
    anim_active = AntGui::Animation.new(AnimationManager.get_anim :channel_hunting_ground_active)
    control = AntGui::Control.new
    canvas.add anim_back
    canvas.add anim_active
    canvas.add control
    AntGui::Canvas.set_canvas_props(anim_back, left, top, width, height)
    AntGui::Canvas.set_canvas_props(anim_active, left, top, width, height)
    AntGui::Canvas.set_canvas_props(control, left + margin_left, top + margin_top,
                                    width - margin_left - margin_right, height - margin_top - margin_bottom)
    anim_back.visible = true
    anim_active.visible = false
    control.on_mouse_enter do
      anim_active.visible = true
    end
    control.on_mouse_leave do
      anim_active.visible = false
    end
    control
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
      image_active.visible = true
      music_sample_instance.resume unless music_sample_instance.nil?
    end
    control.on_mouse_leave do
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

    @font_normal.draw_rel("炸弹持有数量:#{@player_service.shit_mine_count}",
                          left + width - 5, top + height / 2, ZOrder::DIALOG_UI,
                          1.0, 0.5, 1.0, 1.0, 0xBB_000000)
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

  def turn_off_samples
    @sample_instances.each {|sample_instance| sample_instance.volume = 0}
  end

  def turn_on_samples
    @sample_instances.each {|sample_instance| sample_instance.volume = 1}
  end
end