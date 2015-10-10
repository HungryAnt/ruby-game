class LargeRubbishViewModel
  SMASH_DISTANCE = 100

  attr_reader :large_rubbish

  def initialize(large_rubbish)
    @large_rubbish  = large_rubbish
  end

  def id
    @large_rubbish.id
  end

  def x
    @large_rubbish.x
  end

  def y
    @large_rubbish.y
  end

  def draw
    image_index = @large_rubbish.images.size - 1 -
        @large_rubbish.hp * @large_rubbish.images.size / @large_rubbish.max_hp
    image = @large_rubbish.images[image_index]
    image.draw_rot(@large_rubbish.x, @large_rubbish.y, ZOrder::Player, 0)
  end

  def mouse_touch?(mouse_x, mouse_y)
    distance(mouse_x, mouse_y)< 60
  end

  def can_smash?(role)
    distance(role.x, role.y)< SMASH_DISTANCE
  end

  def get_destination(role)
    angle = Gosu::angle(@large_rubbish.x, @large_rubbish.y, role.x, role.y)
    dest_x = @large_rubbish.x + Gosu::offset_x(angle, SMASH_DISTANCE)
    dest_y = @large_rubbish.y + Gosu::offset_y(angle, SMASH_DISTANCE)
    [dest_x, dest_y]
  end

  private
  def distance(x, y)
    Gosu::distance(@large_rubbish.x, @large_rubbish.y, x, y)
  end

  def smash

  end
end