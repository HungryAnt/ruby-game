class EnemyViewModel
  SMASH_DISTANCE = 90

  include AutoScaleModule

  attr_accessor :enemy

  def initialize(enemy)
    init_auto_scale
    @enemy = enemy
  end

  def id
    @enemy.id
  end

  def name
    @enemy.name
  end

  def x
    @enemy.x
  end

  def y
    @enemy.y
  end

  def mouse_touch?(mouse_x, mouse_y)
    distance(mouse_x, mouse_y) < 60
  end

  def can_smash?(role)
    distance(role.x, role.y) <= SMASH_DISTANCE + 1
  end

  def get_destination(role)
    angle = Gosu::angle(enemy_target_x, enemy_target_y, role.x, role.y)
    dest_x = enemy_target_x + Gosu::offset_x(angle, SMASH_DISTANCE)
    dest_y = enemy_target_y + Gosu::offset_y(angle, SMASH_DISTANCE)
    [dest_x, dest_y]
  end

  private
  def distance(x, y)
    Gosu::distance(enemy_target_x, enemy_target_y, x, y)
  end

  def enemy_target_x
    @enemy.x
  end

  def enemy_target_y
    @enemy.y - 10
  end
end