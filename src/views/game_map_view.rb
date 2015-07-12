class GameMapView
  # 每秒产生一个食物
  FOOD_GEN_PER_SECOND = 1

  def initialize(window)
    @window = window
    @player = Player.new(100, 80)
    @foods = []
    @gen_food_timestamp = Gosu::milliseconds
    @font = Gosu::Font.new(20)
    @status_bar_view = StatusBarView.new
    MapManager.switch_map :hill
  end

  def update
    direction = Direction::NONE
    if Gosu::button_down? Gosu::KbUp
      direction |= Direction::UP
    elsif Gosu::button_down? Gosu::KbDown
      direction |= Direction::DOWN
    end

    if Gosu::button_down? Gosu::KbLeft
      direction |= Direction::LEFT
    elsif Gosu::button_down? Gosu::KbRight
      direction |= Direction::RIGHT
    end

    # if direction != Direction::NONE
    #
    # end

    @player.move direction

    seconds = (Gosu::milliseconds - @gen_food_timestamp) / 1000
    gen_count = seconds * FOOD_GEN_PER_SECOND
    @gen_food_timestamp += seconds * 1000

    0.upto(gen_count - 1).each do
      @foods << Food.new(rand * GameConfig::MAP_WIDTH, rand * GameConfig::MAP_HEIGHT)
    end

    @player.collect_foods @foods
  end

  def draw
    MapManager.draw_map
    @player.draw
    @foods.each { |food| food.draw }
    @font.draw("Score: #{@player.score}", 10, 10,
               ZOrder::UI, 1.0, 1.0, 0xff_ffff00)

    @window.translate(0, GameConfig::STATUS_BAR_Y) do
      @status_bar_view.draw
    end
  end

  def button_down(id)
    case id
      when Gosu::Kb1
        MapManager.switch_map :hill
      when Gosu::Kb2
        MapManager.switch_map :school
      when Gosu::MsRight

    end
  end

  def needs_cursor?
    true
  end
end