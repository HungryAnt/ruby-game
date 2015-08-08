# coding: UTF-8
require_relative 'common/text_box'

class UserCreationView
  USER_NAME_TEXT_BOX_WIDTH = 250
  USER_NAME_TEXT_BOX_HEIGHT = 40

  def initialize(window)
    autowired(NetworkService, UserService)
    @window = window

    @font = Gosu::Font.new(30)
    @font_net_error = Gosu::Font.new(18)
    init_user_name_text_box
  end

  def init_user_name_text_box
    @user_name_text_box = TextBox.new(true)
    @user_name_text_box.font = Gosu::Font.new(30)
    @user_name_text_box.default_text =
        %w(孤独的美食家 终极帅哥sl)[rand(2)] + rand(1000).to_s
    @window.text_input = @user_name_text_box.text_input
  end

  def init_enter_game_proc(&enter_game_proc)
    @enter_game_proc = enter_game_proc
  end

  def update

  end

  def draw
    Gosu::draw_rect 0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT, 0xFF_709028, ZOrder::Background

    if @network_service.has_error?
      @font_net_error.draw("#{@network_service.connection_error}", 0, 30, ZOrder::Background,
                           1.0, 1.0, 0xff_f0f0f0, :additive)
      @font.draw_rel('网络连接失败，进入单机版', GameConfig::WHOLE_WIDTH / 2, 60,
                           ZOrder::Background, 0.5, 0.0, 1.0, 1.0, 0xff_f0f0f0, :additive)
    end

    @font.draw_rel('直接键盘输入昵称，按回车键进入游戏', GameConfig::MAP_WIDTH/2, GameConfig::MAP_HEIGHT/2,
                   ZOrder::Background, 0.5, 1.0, 1.0, 1.0, 0xff_f0f0f0, :additive)

    @user_name_text_box.draw((GameConfig::MAP_WIDTH - USER_NAME_TEXT_BOX_WIDTH)/2, GameConfig::MAP_HEIGHT/2 + 40,
                             USER_NAME_TEXT_BOX_WIDTH, USER_NAME_TEXT_BOX_HEIGHT)
  end

  def button_down(id)
    if id == Gosu::KbReturn
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
    @enter_game_proc.call
  end
end