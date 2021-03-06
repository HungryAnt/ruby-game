module GamePet
  def init_pets
    @pet_vm_dict = {}
    register_update_pet_callback
    register_update_pet_lv_callback
  end

  def pet_move_to(mouse_x, mouse_y)
    return if @player_view_model.pets_vms.count == 0
    actual_x, actual_y = to_area_actual_location mouse_x, mouse_y
    map_vm = get_current_map
    unless map_vm.tile_block? actual_x, actual_y
      map_vm.mark_target(mouse_x, mouse_y) unless map_vm.nil?
      @player_view_model.pet_move_to actual_x, actual_y
    end
  end

  def take_pets
    @player_view_model.take_pets
  end

  private

  def register_update_pet_callback
    @pet_communication_handler.register_update_pet_callback do |pet_msg|
      if is_in_chat_map
        pet_id = pet_msg.pet_id
        destination = pet_msg.destination
        if !@player_view_model.contains_pet_id?(pet_id)
          update_pet pet_msg.area_id.to_sym, pet_msg.pet_id, pet_msg.pet_type.to_sym,
                     pet_msg.action, pet_msg.pet_map, destination
        end
      end
    end
  end

  def register_update_pet_lv_callback
    @pet_communication_handler.register_update_pet_lv_callback do |update_pet_lv_msg|
      pet_vm = @player_view_model.get_pet update_pet_lv_msg.pet_id
      unless pet_vm.nil?
        pet_vm.pet.update_lv_exp update_pet_lv_msg.lv, update_pet_lv_msg.exp_in_lv, update_pet_lv_msg.max_exp_in_lv
      end
    end
  end

  def update_pet(area_id, pet_id, pet_type, action, pet_map, destination)
    if action == PetMessage::APPEAR || action == PetMessage::ATTACK
      pet_vm = get_pet_vm(pet_id, pet_type)

      pet_vm.area_id = area_id
      pet_vm.pet.x = pet_map['x'].to_i
      pet_vm.pet.y = pet_map['y'].to_i
      pet_vm.pet.state = pet_map['state'].to_sym
      pet_vm.pet.durable_state = pet_map['durable_state'].to_sym
      pet_vm.pet.direction = pet_map['direction']

      if destination.size > 0
        pet_vm.move_to destination['x'].to_i, destination['y'].to_i
      end

      if action == PetMessage::ATTACK
        pet_vm = @pet_vm_dict[pet_id]
        quiet = area_id != get_current_area.id
        pet_vm.attack(quiet) unless pet_vm.nil?
      end

    elsif action == PetMessage::DISAPPEAR
      pet_vm = @pet_vm_dict[pet_id]
      pet_vm.area_id = :none unless pet_vm.nil?
    end
  end

  def get_pet_vm(pet_id, pet_type)
    pet_vm = @pet_vm_dict[pet_id]
    if pet_vm.nil?
      pet = Pet.new(pet_id, pet_type, 110, 310)
      pet_vm = PetViewModel.new(pet)
      @pet_vm_dict[pet_id] = pet_vm
    end
    pet_vm
  end

  def travel_other_pet_vms
    area_id = get_current_area.id
    @pet_vm_dict.each_value do |pet_vm|
      yield pet_vm if pet_vm.area_id == area_id
    end
  end
end