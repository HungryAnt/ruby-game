class ShitMineViewModel
  include AutoScaleModule

  BOMB_DURING_TIME = 1400

  def initialize(shit_mine)
    @shit_mine = shit_mine
    init_animations
    @is_bomb = false
    @check_player_battered = false
    @sound_bomb = MediaUtil.get_sample 'skill/SkillBomb_2_5.wav'
  end

  def id
    @shit_mine.id
  end

  def x
    @shit_mine.x
  end

  def y
    @shit_mine.y
  end

  def update(area, player_vm)
    if @is_bomb
      unless @check_player_battered
        player_vm.check_hit_battered ShitMine::BOMB, x, y
        @check_player_battered = true
      end
    end
  end

  def draw(auto_scale_info)
    update_scale auto_scale_info, y
    if @is_bomb
      @bomb_anim.draw(x, y, ZOrder::Player, mode: :additive, scale_x:scale_value, scale_y:scale_value)
    else
      @shit_anim.draw(x, y, ZOrder::Player, scale_x:scale_value, scale_y:scale_value)
    end
  end

  def bomb(quiet=false)
    @sound_bomb.play unless quiet
    @bomb_time = Gosu::milliseconds
    @is_bomb = true
    anim_goto_begin
  end

  def should_destroy?
    @is_bomb && Gosu::milliseconds - @bomb_time >= BOMB_DURING_TIME
  end

  private

  def init_animations
    @shit_anim = AnimationManager.get_anim :shit_mine
    @bomb_anim = AnimationManager.get_anim :shit_mine_bomb
    anim_goto_begin
  end

  def anim_goto_begin
    @anim_init_timestamp = Gosu::milliseconds
  end
end