class ShitMineViewModel
  include AutoScaleModule

  def initialize(shit_mine)
    @shit_mine = shit_mine
    init_animations
  end

  def x
    @shit_mine.x
  end

  def y
    @shit_mine.y
  end

  def draw(auto_scale_info)
    update_scale auto_scale_info, y
    @anim.draw(x, y, ZOrder::Player, scale_x:scale_value, scale_y:scale_value)
  end

  def bomb

  end

  private

  def init_animations
    @anim = AnimationManager.get_anim :shit_mine
  end
end