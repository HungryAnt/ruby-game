class GameMapView < ViewBase

  def initialize(window)
    @window = window
    player = GameManager.player_service.player
    @player_view_model = PlayerViewModel.new(player)
    @food_view_models = []
    @gen_food_timestamp = Gosu::milliseconds
    @font = Gosu::Font.new(20)
    @status_bar_view = StatusBarView.new
    MapManager.switch_map :hill
  end

  def update
    @status_bar_view.update

    MapManager.update_map

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

    @player_view_model.move direction, MapManager::current_map

    seconds = (Gosu::milliseconds - @gen_food_timestamp) / 1000
    gen_count = (seconds * GameConfig::FOOD_GEN_PER_SECOND).to_i
    if gen_count > 0
      @gen_food_timestamp += seconds * 1000

      0.upto(gen_count - 1).each do
        # @food_view_models << Food.new(rand * GameConfig::MAP_WIDTH, rand * GameConfig::MAP_HEIGHT)
        food = Food.new(*MapManager::current_map.random_available_position)
        @food_view_models << FoodViewModel.new(food)
      end
    end
    @player_view_model.collect_foods @food_view_models #.map {|food_mv| food_mv.food}
  end

  def draw
    MapManager.draw_map
    @player_view_model.draw
    @food_view_models.each { |food_vm| food_vm.draw }
    @font.draw("Score: #{@player_view_model.score}", 10, 10,
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
        MapManager.current_map.mark_target(@window.mouse_x, @window.mouse_y) unless MapManager.current_map.nil?
    end
  end

  def needs_cursor?
    true
  end
end