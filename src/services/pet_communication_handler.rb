class PetCommunicationHandler
  def initialize
    @update_pet_callback = nil
  end

  def register_update_pet_callback(&callback)
    @update_pet_callback = callback
  end

  def update_pet(pet_msg)
    @update_pet_callback.call pet_msg
  end
end