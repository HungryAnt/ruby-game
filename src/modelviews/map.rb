class Map
  def initialize(areas)
    ArgumentError "wrong areas #{areas}" if areas.nil? || areas.size == 0
    @areas = areas
    @current_area = @areas[0]
  end

  def activate
    @current_area.activate
  end

  def draw
    @current_area.draw
  end
end