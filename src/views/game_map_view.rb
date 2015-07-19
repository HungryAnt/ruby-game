class GameMapView < ViewBase

  def initialize(window)
    @window = window
    player = GameManager.player_service.player
    @player_view_model = PlayerViewModel.new(player)
    @gen_food_timestamp = Gosu::milliseconds
    @status_bar_view = StatusBarView.new
    MapManager.switch_map :grass_wood_back
  end

  def update
    @status_bar_view.update

    MapManager.update_map

    direction = Direction::NONE
    if Gosu::button_down?(Gosu::KbUp) || Gosu::button_down?(Gosu::KbW)
      direction |= Direction::UP
    elsif Gosu::button_down?(Gosu::KbDown) || Gosu::button_down?(Gosu::KbS)
      direction |= Direction::DOWN
    end

    if Gosu::button_down?(Gosu::KbLeft) || Gosu::button_down?(Gosu::KbA)
      direction |= Direction::LEFT
    elsif Gosu::button_down?(Gosu::KbRight) || Gosu::button_down?(Gosu::KbD)
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

      food_vms = get_food_vms
      0.upto(gen_count - 1).each do
        # @food_view_models << Food.new(rand * GameConfig::MAP_WIDTH, rand * GameConfig::MAP_HEIGHT)
        food = FoodFactory.random_food(*MapManager::current_map.random_available_position)
        food_vms << FoodViewModel.new(food)
      end
    end

    # @player_view_model.collect_foods @food_view_models #.map {|food_mv| food_mv.food}

    @player_view_model.update
  end

  def draw
    MapManager.draw_map
    @player_view_model.draw
    get_food_vms.each { |food_vm| food_vm.draw }
    @window.translate(0, GameConfig::STATUS_BAR_Y) do
      @status_bar_view.draw
    end
  end

  def button_down(id)
    case id
      when Gosu::Kb1
        MapManager.switch_map :grass_wood_back
      when Gosu::Kb2
        MapManager.switch_map :school
      when Gosu::MsLeft
        done = pick_up @window.mouse_x, @window.mouse_y
        return if done
        done = goto_area @window.mouse_x, @window.mouse_y
        return if done
        set_destination @window.mouse_x, @window.mouse_y
      when Gosu::MsRight

      # when Gosu::KbE
      #   @player_view_model.start_eat_food
      when Gosu::KbF
        @player_view_model.discard get_food_vms
    end
  end

  def pick_up(mouse_x, mouse_y)
    food_vms = get_food_vms
    food_vms.each do |food_vm|
      if food_vm.mouse_touch?(mouse_x, mouse_y) && food_vm.can_pick_up?(@player_view_model.role)
        food_vms.reject! { |item| item == food_vm }
        @player_view_model.pick_up food_vm
        return true
      end
    end
    false
  end

  def goto_area(mouse_x, mouse_y)
    map_vm = MapManager.current_map
    if map_vm.gateway? mouse_x, mouse_y, @player_view_model.role
      @player_view_model.disable_auto_move
      map_vm.goto_area mouse_x, mouse_y, @player_view_model.role
      return true
    end
    false
  end

  def set_destination(mouse_x, mouse_y)
    map_vm = MapManager.current_map
    unless map_vm.tile_block? mouse_x, mouse_y
      map_vm.mark_target(mouse_x, mouse_y) unless MapManager.current_map.nil?
      @player_view_model.set_destination mouse_x, mouse_y
    end
  end

  def needs_cursor?
    true
  end

  private
  def get_food_vms
    MapManager.current_map.current_area.food_vms
  end
end