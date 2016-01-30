class Direction
  NONE = 0
  NORTH = UP = 1
  NORTH_EAST = 1 | 2
  EAST = RIGHT = 2
  SOUTH_EAST = 2 | 4
  SOUTH = DOWN = 4
  SOUTH_WEST = 4 | 8
  WEST = LEFT = 8
  NORTH_WEST = 1 | 8

  ROLE_NORMAL_DIRECTIONS = [Direction::DOWN, Direction::LEFT, Direction::UP, Direction::RIGHT]

  def self.to_angle(direction)
    case direction
      when NORTH
        return 0
      when NORTH_EAST
        return 45
      when EAST
        return 90
      when SOUTH_EAST
        return 135
      when SOUTH
        return 180
      when SOUTH_WEST
        return 225
      when WEST
        return 270
      when NORTH_WEST
        return 315
      else
        raise ArgumentError "wong direction #{direction}"
    end
  end

  # todo refactor
  def self.is_direct_to_left(direction)
    is_direct_to(direction, LEFT)
  end

  def self.is_direct_to_right(direction)
    is_direct_to(direction, RIGHT)
  end

  def self.is_direct_to_up(direction)
    is_direct_to(direction, UP)
  end

  def self.is_direct_to_down(direction)
    is_direct_to(direction, DOWN)
  end

  def self.to_direction_text(direction)
    if is_direct_to_left(direction)
      return 'left'
    elsif is_direct_to_right(direction)
      return 'right'
    elsif is_direct_to_up(direction)
      return 'up'
    else
      return 'down'
    end
  end

  private
  def self.is_direct_to(direction, target_direction)
    direction & target_direction == target_direction
  end
end