class StatusBarView
  def initialize
    @img = MediaUtil::get_tileable_img('ui/status_bar.bmp')
    @player = get_instance(PlayerService).role
    @hp_width = 0
    @exp_width = 0
    @font = Gosu::Font.new(14)
  end

  def update
    @hp_width = 111 * @player.hp / @player.max_hp
    @exp_width = 111 * @player.exp / @player.max_exp
  end

  def draw
    @img.draw(0, 0, ZOrder::UI)
    Gosu::draw_rect(480, 32, @hp_width, 5, 0xFF_0090F7, ZOrder::UI)
    Gosu::draw_rect(480, 44, @exp_width, 5, 0xFF_F4003D, ZOrder::UI)
    @font.draw_rel("lv.#{@player.lv}", 416, 39,
               ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xFF_EFC39E)
  end
end