class PlayerPetViewModel < PetViewModel
  def initialize(pet)
    autowired(MapService, CommunicationService)
    @order_time_stamp = 0
    super
  end

  def appear_with_owner(role)
    @pet.x, @pet.y = role_side_location(role, 20)
    @pet.disable_auto_move
  end

  def order_move_to(target_x, target_y)
    move_to target_x, target_y
    @order_time_stamp = Gosu::milliseconds
  end

  def update(area, role)
    @update_times += 1
    if Gosu::milliseconds - @order_time_stamp > 8000
      if rand(5 * GameConfig::FPS) == 0
        rand_num = rand 10
        if rand_num < 4
          move_random area
        elsif rand_num < 6
          move_to_owner role
        else
          sleep
        end
      end
    end
    super(area)
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
    remote_sync_data
  end

  def cute
    super
    remote_sync_data
  end

  def appear
    remote_sync_data
  end

  def disappear
    remote_sync_data PetMessage::DISAPPEAR
  end

  private

  def role_side_location(role, offset)
    [role.x + offset - rand(offset*2), role.y + offset - rand(offset*2)]
  end

  def remote_move_to(target_x, target_y)
    destination = {x: target_x, y: target_y}
    remote_sync_data PetMessage::APPEAR, destination
  end

  def remote_sync_data(action = PetMessage::APPEAR, destination = {})
    pet_msg = PetMessage.new @pet.pet_id, @pet.pet_type, action, @pet.to_map,
                             get_current_map_id, get_current_area_id,
                             destination
    @communication_service.send_pet_message pet_msg
  end

  def get_current_map_id
    @map_service.current_map.id.to_s
  end

  def get_current_area_id
    @map_service.current_map.current_area.id.to_s
  end
end