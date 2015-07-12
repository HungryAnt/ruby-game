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

  def target(x, y)
    @current_area.target x, y
  end
end