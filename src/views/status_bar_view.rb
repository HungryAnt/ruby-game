class StatusBarView
  def initialize
    @img = MediaUtil::get_tileable_img('ui/status_bar.bmp')
    @player = GameManager.player_service.player
    @hp_width = 0
  end

  def update
    @hp_width = 111 * @player.hp / @player.max_hp
  end

  def draw
    @img.draw(0, 0, ZOrder::UI)
    Gosu::draw_rect(480, 31, @hp_width, 6, 0xFF_FF1111, ZOrder::UI)
  end
end