# coding: UTF-8
require_relative 'common/text_box'

class RoleTypeControl < AntGui::Control
  attr_accessor :selected

  def initialize(role_type, border_image)
    super()
    @role_type = role_type
    @border_image = border_image
    @image_unselected = AntGui::Image.new(RoleTypeDefinition.get_role_unselected_photo(role_type))
    @image_selected = AntGui::Image.new(RoleTypeDefinition.get_role_selected_photo(role_type))
  end

  def update(selected_role_type)
    selected = selected_role_type == @role_type
    if selected
      @content = @image_selected
    else
      @content = @image_unselected
    end
    @border_image.visible = selected
  end
end

class UserCreationView
  USER_NAME_TEXT_BOX_WIDTH = 250
  USER_NAME_TEXT_BOX_HEIGHT = 40

  ROLE_PHOTO_WIDTH = 91
  ROLE_PHOTO_HEIGHT = 87
  ROLE_PHOTO_MARGIN = 10
  ROLE_SELECTOR_COL_COUNT = 6
  ROLE_SELECTOR_ROW_COUNT = 2

  def initialize(window)
    autowired(NetworkService, UserService, WindowResourceService, SongService)
    @window = window

    @font = Gosu::Font.new(30)
    @font_net_error = Gosu::Font.new(18)
    init_user_name_text_box
    init_role_type_selector
    update_role_type_selector @user_service.role_type

    @song_service.play_song('Title_New.ogg')
  end

  def init_user_name_text_box
    @user_name_text_box = TextBox.new(true)
    @user_name_text_box.font = Gosu::Font.new(30)
    @user_name_text_box.default_text = @user_service.user_name
        # %w(孤独的美食家 终极帅哥sl)[rand(2)] + rand(1000).to_s
    @window.text_input = @user_name_text_box.text_input
  end

  def init_role_type_selector
    @sound_button = @window_resource_service.get_sound_button  # MediaUtil.get_sample 'button.wav'
    dialog_width = ROLE_PHOTO_WIDTH * ROLE_SELECTOR_COL_COUNT + ROLE_PHOTO_MARGIN * (ROLE_SELECTOR_COL_COUNT - 1)
    dialog_height = ROLE_PHOTO_WIDTH * ROLE_SELECTOR_ROW_COUNT + ROLE_PHOTO_MARGIN * (ROLE_SELECTOR_ROW_COUNT - 1)
    dialog_left = (GameConfig::WHOLE_WIDTH - dialog_width) / 2
    dialog_top = 120
    @dialog_role_type_selector = AntGui::Dialog.new(dialog_left, dialog_top, dialog_width, dialog_height)
    # @dialog_role_type_selector.background_color = 0xFF_709028
    canvas = AntGui::Canvas.new
    @dialog_role_type_selector.content = canvas

    role_types = RoleType.get_all_types
    @role_type_controls = []

    0.upto(ROLE_SELECTOR_ROW_COUNT - 1) do |row|
      0.upto(ROLE_SELECTOR_COL_COUNT - 1) do |col|
        left = (ROLE_PHOTO_WIDTH  + ROLE_PHOTO_MARGIN) * col
        top = (ROLE_PHOTO_HEIGHT + ROLE_PHOTO_MARGIN) * row
        role_type = role_types[row * ROLE_SELECTOR_COL_COUNT + col]
        border_image = AntGui::Image.new(MediaUtil.get_img('role/koongya/ui/border.bmp'))
        role_type_control = RoleTypeControl.new role_type, border_image
        AntGui::Canvas.set_canvas_props(role_type_control, left, top, ROLE_PHOTO_WIDTH, ROLE_PHOTO_HEIGHT)
        AntGui::Canvas.set_canvas_props(border_image, left, top, ROLE_PHOTO_WIDTH, ROLE_PHOTO_HEIGHT)
        canvas.add role_type_control
        canvas.add border_image

        @role_type_controls << role_type_control
        role_type_control.on_mouse_left_button_down do
          update_role_type_selector role_type
          @dialog_role_type_selector.update_arrange
          @sound_button.play
        end
      end
    end

    update_role_type_selector(@user_service.role_type)
    @dialog_role_type_selector.update_arrange
  end

  def init_enter_game_proc(&enter_game_proc)
    @enter_game_proc = enter_game_proc
  end

  def update_role_type_selector(role_type)
    @role_type_controls.each {|control| control.update(role_type)}
    @selected_role_type = role_type
  end

  def update

  end

  def draw
    # Gosu::draw_rect 0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT, 0xFF_005020, ZOrder::Background
    GraphicsUtil.draw_linear_rect(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT,
                                  ZOrder::Background, 0xFF_005020, 0xFF_2DBF68)

    if @network_service.has_error?
      @font_net_error.draw("#{@network_service.connection_error}", 0, 30, ZOrder::Background,
                           1.0, 1.0, 0xff_f0f0f0, :additive)
      @font.draw_rel('网络连接失败，请联系管理员', GameConfig::WHOLE_WIDTH / 2, 60,
                           ZOrder::Background, 0.5, 0.0, 1.0, 1.0, 0xff_f0f0f0, :additive)
    end

    @dialog_role_type_selector.draw

    center_y = GameConfig::MAP_HEIGHT/2

    @font.draw_rel('输入昵称，回车开始游戏', GameConfig::MAP_WIDTH/2, center_y + 40,
                   ZOrder::Background, 0.5, 0.0, 1.0, 1.0, 0xff_f0f0f0, :additive)

    @user_name_text_box.draw((GameConfig::MAP_WIDTH - USER_NAME_TEXT_BOX_WIDTH)/2, center_y + 100,
                             USER_NAME_TEXT_BOX_WIDTH, USER_NAME_TEXT_BOX_HEIGHT)

    @font.draw_rel('回车键聊天', GameConfig::MAP_WIDTH/2, center_y + 180,
                   ZOrder::Background, 0.5, 0.0, 1.0, 1.0, 0xff_ffff00, :additive)
  end

  def button_down(id)
    case id
      when Gosu::MsLeft
        @dialog_role_type_selector.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
      when Gosu::KbReturn
        enter_game
    end
  end

  def button_up(id)

  end

  def needs_cursor?
    true
  end

  def enter_game
    user_name = @user_name_text_box.text
    user_name = @user_name_text_box.default_text if user_name == ''
    puts "enter_game, user_name: #{user_name}"
    @user_service.user_name = user_name
    @user_service.role_type = @selected_role_type
    @user_service.save
    @enter_game_proc.call
  end
end