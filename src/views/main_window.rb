# coding: UTF-8

class MainWindow < Gosu::Window
  def initialize(version, screen_mode)
    fullscreen = screen_mode == 'fullscreen'
    super GameConfig::MAP_WIDTH,
          GameConfig::MAP_HEIGHT + GameConfig::BOTTOM_HEIGHT, fullscreen:fullscreen, update_interval:1000/40
    autowired(WindowResourceService, PlayerService, MapService)

    @version = version

    @window_resource_service.init(self)
    self.caption = "Ant野菜部落 华丽正式版 #{@version}    —— 交流QQ群:513951420"

    @warning_font = @window_resource_service.get_warning_font
    @is_cheating = false
    @anti_cheating_info = []

    @begin_times = Gosu::milliseconds
    @update_times = 0
    @draw_times = 0
    @font = Gosu::Font.new(20)

    init_all_views

    MessageBox.register self
  end

  def init_all_views
    @user_creation_view = UserCreationView.new(self)
    @loading_view = LoadingView.new
    @channel_main_view = ChannelMainView.new(self)
    @game_map_view = GameMapView.new(self)
    @map_editor_view = MapEditorView.new(self)
    @shopping_view = ShoppingView.new(self)
    @pet_union_view = PetUnionView.new(self)

    @ready_for_game = false

    @user_creation_view.init_enter_game_proc do
      @player_service.init
      @current_view = @loading_view
    end

    @loading_view.init_skip_call_back do
      @player_service.update_sync_data
      @game_map_view.init
      @current_view = @channel_main_view
      @channel_main_view.active
      @ready_for_game = true
      init_anti_cheating
    end

    @channel_main_view.register_select_map do |map_id|
      @game_map_view.init_switch_map map_id
      @current_view = @game_map_view
    end
    @channel_main_view.on_exit {close}

    @game_map_view.on_exit do
      @current_view = @channel_main_view
      @channel_main_view.active
    end

    @channel_main_view.on_shop do
      # @current_view = @shopping_view
      # @shopping_view.active

      @current_view = @pet_union_view
    end

    @shopping_view.on_exit do
      @current_view = @channel_main_view
      @channel_main_view.active
    end

    @current_view = @user_creation_view
  end

  def init_anti_cheating
    anti_cheating_service = AntiCheatingService.new(@player_service.user_id)
    anti_cheating_service.init_check_cheating_thread

    anti_cheating_service.on_cheating do
      @is_cheating = true
      @anti_cheating_info = []
      @anti_cheating_info << '本游戏严禁使用加速器等作弊软件'
      @anti_cheating_info << '情节严重者封号处理'
      @anti_cheating_info << '游戏将在10秒后退出'
      sleep(10)
      close
    end
  end

  def update
    MessageBox.update
    @current_view.update
    @update_times += 1
    if @update_times == 60
      @update_times = 0
      @draw_times = 0
      @begin_times = Gosu::milliseconds
    end
  end

  def draw
    @current_view.draw
    @draw_times += 1

    draw_fps

    # Gosu::draw_rect 0, 0, 20 * 30, 20, 0xAA_EFEF56
    # message = '作者:Ant(群主大大大) QQ:517377100 千人火爆交流Q群:513951420'
    #
    # @font.draw(message, 11, 1,
    #            ZOrder::DIALOG_UI, 1.0, 1.0, 0xFF_9EC4FF)
    # @font.draw(message, 10, 0,
    #            ZOrder::DIALOG_UI, 1.0, 1.0, 0xFF_2054A3)

    if @is_cheating
      Gosu::draw_rect 0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT, 0xAA_550015, ZOrder::DIALOG_UI
      y = GameConfig::MAP_HEIGHT/2 - 50
      @anti_cheating_info.each do |info|
        @warning_font.draw_rel(info, GameConfig::MAP_WIDTH/2, y,
                               ZOrder::DIALOG_UI, 0.5, 0.5, 1.0, 1.0, 0xFF_FFFFFF, :additive)
        y += 35
      end
    end

    # img = MediaUtil.get_img 'action_effect/RunEffect_108.bmp'
    # img.draw(0, 0, ZOrder::DIALOG_UI, 1.0, 1.0, 0xff_ffffff, mode = :additive)

    MessageBox.show
  end

  def draw_fps
    if GameConfig::DEBUG
      diff = Gosu::milliseconds - @begin_times
      return if diff == 0

      @font.draw('Debug', 10, 30, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      # update_rate = @update_times * 1000 / diff
      # @font.draw("update: #{update_rate} per second", 10, 30,
      #            ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      #
      # draw_rate = @draw_times * 1000 / diff
      # @font.draw("draw: #{draw_rate} per second", 10, 50,
      #            ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    end
  end

  def button_down(id)
    return if MessageBox.button_down id
    @current_view.button_down id

    if @ready_for_game && GameConfig::DEBUG
      case id
        when Gosu::KbF1
          @current_view = @game_map_view
        when Gosu::KbF3
          @map_editor_view.init_areas
          @current_view = @map_editor_view
        when Gosu::KbF5
          # file_path = File.join(File.dirname(__FILE__), '../config/equipment_eye_wear_config.rb')
          load 'config/equipment_eye_wear_config.rb'
          load 'config/equipment_handheld_config.rb'
          load 'config/equipment_hat_config.rb'
          load 'config/equipment_underpan_config.rb'
          load 'config/equipment_vehicle_config.rb'
          load 'config/equipment_wing_config.rb'
          load 'config/equipment_ear_wear_config.rb'
          load 'config/equipment_background_config.rb'
          load 'config/equipment_foreground_config.rb'
          load 'config/pet_config.rb'
          @player_service.refresh_all_equipments

          load 'config/monster_config.rb'
          @map_service.all_maps.each do |map_vm|
            map_vm.areas.each do |area_vm|
              area_vm.get_monster_vms.each do |monster_vm|
                monster_vm.monster.refresh
              end
            end
          end
        when Gosu::KbF6
          EquipmentDefinition.print_all_keys
          PetTypeInfo.print_all_pets
        when Gosu::KbI
          # MessageBox.info 'test1111111111111111', MessageBox::BoxType::BOX_OK
        when Gosu::KbO
          # MessageBox.info 'test1111111111111111', MessageBox::BoxType::BOX_OK_CANCEL
      end
    end
  end

  def button_up(id)
    @current_view.button_up id
  end

  def needs_cursor?
    @current_view.needs_cursor?
  end
end

