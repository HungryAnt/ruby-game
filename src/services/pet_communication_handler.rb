class PetCommunicationHandler
  def initialize
    @update_pet_callback = nil
    @update_pet_lv_callback = nil
  end

  def register_update_pet_callback(&callback)
    @update_pet_callback = callback
  end

  def update_pet(pet_msg)
    @update_pet_callback.call pet_msg
  end

  def register_update_pet_lv_callback(&callback)
    @update_pet_lv_callback = callback
  end

  def update_pet_lv(update_pet_lv_msg)
    @update_pet_lv_callback.call update_pet_lv_msg
  end
end