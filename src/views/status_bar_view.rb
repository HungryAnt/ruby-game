class StatusBarView
  include MouseTips

  VALUE_BAR_WIDTH = 111
  VALUE_BAR_HEIGHT = 5
  VALUE_BAR_LEFT = 480
  HP_BAR_TOP = 32
  EXP_BAR_TOP = 44

  def initialize
    autowired(WindowResourceService)
    @img = MediaUtil::get_tileable_img('ui/status_bar.bmp')
    @player = get_instance(PlayerService).role
    @hp_width = 0
    @exp_width = 0
    @font = Gosu::Font.new(14)
    init_mana
    init_mouse_tips
  end

  def update
    @hp_width = VALUE_BAR_WIDTH * @player.hp / @player.max_hp
    @exp_width = VALUE_BAR_WIDTH * @player.exp / @player.max_exp
  end

  def draw
    @img.draw(0, 0, ZOrder::UI)
    Gosu::draw_rect(VALUE_BAR_LEFT, HP_BAR_TOP, @hp_width, VALUE_BAR_HEIGHT, 0xFF_0090F7, ZOrder::UI)
    Gosu::draw_rect(VALUE_BAR_LEFT, EXP_BAR_TOP, @exp_width, VALUE_BAR_HEIGHT, 0xFF_F4003D, ZOrder::UI)
    @font.draw_rel("lv.#{@player.lv}", 416, 39,
               ZOrder::UI, 0.5, 0.5, 1.0, 1.0, 0xFF_EFC39E)
    draw_mana
  end

  def update_mouse(mouse_x, mouse_y)
    set_tips_text nil

    if GraphicsUtil.pt_in_rect? mouse_x, mouse_y, VALUE_BAR_LEFT, GameConfig::STATUS_BAR_Y + HP_BAR_TOP,
                                VALUE_BAR_WIDTH, VALUE_BAR_HEIGHT
      set_tips_text (100 * @player.hp.to_i / @player.max_hp).to_s + '%'
      return
    end

    if GraphicsUtil.pt_in_rect? mouse_x, mouse_y, VALUE_BAR_LEFT, GameConfig::STATUS_BAR_Y + EXP_BAR_TOP,
                                VALUE_BAR_WIDTH, VALUE_BAR_HEIGHT
      set_tips_text format('%.2f', 100.0 * @player.exp / @player.max_exp) + '%'
      return
    end
  end

  private

  def init_mana
    @mana_anims = []

    0.upto(9) do |i|
      key = "mana_#{i}".to_sym
      @mana_anims << AnimationManager.get_anim(key)
    end
  end

  def draw_mana
    mana_index = (@player.mana / 100.1 * 10).to_i
    mana_anim = @mana_anims[mana_index]
    mana_anim.draw(6, 4, ZOrder::UI)
  end
end