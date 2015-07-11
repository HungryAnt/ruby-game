class MapEditorView

  def initialize
    maps = MapManager::all_maps
    @imgs = []

    maps.each do |map|
      map.areas.each do |area|
        @imgs << area.image
      end
    end

    @img_index = 0
    @current_img = @imgs[@img_index]
  end

  def update

  end

  def draw
    @current_img.draw(0, 0, ZOrder::Background, 1, 1)
  end

  def button_down(id)
    if id >= Gosu::Kb1 && id <= Gosu::Kb9
      @img_index = id - Gosu::Kb1
    elsif id == Gosu::KbLeft || id == Gosu::KbUp
      @img_index -= 1
    elsif id == Gosu::KbRight || id == Gosu::KbDown
      @img_index += 1
    end
    @img_index = [@imgs.size - 1, @img_index].min
    @img_index = [0, @img_index].max
    @current_img = @imgs[@img_index]
  end
end