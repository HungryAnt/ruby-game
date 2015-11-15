module Movable
  attr_accessor :running, :standing

  def init_movable(speed, area_block_enabled = true)
    @area_block_enabled = area_block_enabled
    @auto_move_enabled = false
    @auto_move_angle = 0
    @auto_move_dest = {x: 0, y: 0}
    @running = false
    @standing = true
    @arrive_call_back = nil
    @speed = speed
  end

  def set_auto_move_to(target_x, target_y, &arrive_call_back)
    @auto_move_enabled = true
    @auto_move_angle = Gosu::angle(x, y, target_x, target_y)
    @auto_move_dest = {x: target_x, y: target_y}
    @arrive_call_back = arrive_call_back
  end

  def auto_move(area)
    if @auto_move_enabled
      adjust_to_suit_direction(@auto_move_dest[:x], @auto_move_dest[:y])
      do_move @auto_move_angle, area, @auto_move_dest
    end
  end

  def disable_auto_move
    @auto_move_enabled = false
    stop
  end

  def adjust_to_suit_direction(target_x, target_y)
    @direction = calc_suit_direction target_x, target_y
  end

  private

  def get_speed
    @speed
  end

  def calc_suit_direction(target_x, target_y)
    x_diff = target_x - x
    y_diff = target_y - y
    if x_diff.abs > y_diff.abs
      x_diff < 0 ? Direction::LEFT : Direction::RIGHT
    else
      y_diff < 0 ? Direction::UP : Direction::DOWN
    end
  end

  def do_move(angle, area, destination)
    speed = get_speed
    dest_x = destination[:x]
    dest_y = destination[:y]
    if Gosu::distance(x, y, dest_x, dest_y) <= speed
      move_to_location(dest_x, dest_y)
      complete_auto_move
      @running = false
      @standing = true
      return
    end

    next_x = x + Gosu::offset_x(angle, speed)
    next_y = y + Gosu::offset_y(angle, speed)

    if @area_block_enabled && area.tile_block?(next_x, next_y)
      disable_auto_move
    else
      move_to_location next_x, next_y
    end
  end

  def stop
    @standing = true
    @running = false
  end

  def move_to_location(loc_x, loc_y)
    @standing = false
    @x = loc_x
    @y = loc_y
  end

  def complete_auto_move
    disable_auto_move
    @arrive_call_back.call unless @arrive_call_back.nil?
  end
end