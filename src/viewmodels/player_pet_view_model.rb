class PlayerPetViewModel < PetViewModel
  def initialize(pet)
    autowired(MapService, CommunicationService)
    super
  end

  def appear_with_owner(role)
    @pet.x, @pet.y = role_side_location(role, 20)
  end

  def update(area, role)
    @update_times += 1
    if rand(5 * GameConfig::FPS) == 0
      rand_num = rand 10
      if rand_num < 4
        move_random area
      elsif rand_num < 6
        move_to_owner role
      elsif rand_num < 9
        sleep
      end
    end
    super
  end

  def move_random(area)
    move_to *area.random_available_position
  end

  def move_to_owner(role)
    if Gosu::distance(x, y, role.x, role.y) < 55
      cute
    else
      move_to *role_side_location(role, 50)
    end
  end

  def move_to(target_x, target_y)
    super
    remote_move_to target_x, target_y
  end

  def sleep
    super
    remote_sleep
  end

  def cute
    super
    remote_cute
  end

  private

  def role_side_location(role, offset)
    [role.x + offset - rand(offset*2), role.y + offset - rand(offset*2)]
  end

  def get_current_area_id
    @map_service.current_map.current_area.id.to_s
  end

  def remote_move_to(target_x, target_y)

  end

  def remote_sleep

  end

  def remote_cute

  end
end