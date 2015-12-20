class MonstersService
  def initialize
    @monster_msg_callback = nil
  end

  def register_monster_msg_callback(&callback)
    @monster_msg_callback = callback
  end

  def add_monster_msg(monster_msg)
    @monster_msg_callback.call monster_msg
  end
end