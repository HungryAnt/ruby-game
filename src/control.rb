module Control
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

  end
end