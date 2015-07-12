class Map
  attr_reader :areas

  def initialize(areas)
    ArgumentError "wrong areas #{areas}" if areas.nil? || areas.size == 0
    @areas = areas
    @current_area = @areas[0]
  end

  def update
    @current_area.update
  end

  def draw
    @current_area.draw
  end

  def activate
    @current_area.activate
  end

  def mark_target(x, y)
    @current_area.mark_target x, y
  end

  def tile_block?(x, y)
    @current_area.tile_block? x, y
  end

  def random_available_position
    @current_area.random_available_position
  end
end