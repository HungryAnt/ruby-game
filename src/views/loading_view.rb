# coding: UTF-8

class LoadingView
  def initialize
    autowired(UserService)
    @font = Gosu::Font.new(30)
    @font_net_error = Gosu::Font.new(18)
    @skip_call_back = nil
    end

  def init_skip_call_back(&skip_call_back)
    @skip_call_back = skip_call_back
  end

  def update
    check_user_lv_synced
  end

  def draw
    Gosu::draw_rect 0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT, 0xFF_005020, ZOrder::Background

    @font.draw_rel('加载游戏，请等待数秒...若无法进入请联系管理员', GameConfig::MAP_WIDTH/2, GameConfig::MAP_HEIGHT/2,
                   ZOrder::Background, 0.5, 0.5, 1.0, 1.0, 0xff_f0f0f0, :additive)
  end

  def button_down(id)

  end

  def button_up(id)

  end

  def needs_cursor?
    true
  end

  def check_user_lv_synced
    if @user_service.data_synced?
      skip
    end
  end

  def skip
    @skip_call_back.call unless @skip_call_back.nil?
  end
end