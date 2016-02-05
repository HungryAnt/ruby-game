
# ±ã±ãÀ×
class ShitMine
  BOMB = :shit_mine_bomb

  include Location

  attr_reader :id, :user_id

  def initialize(id, user_id, x, y)
    init_location x, y
    @id, @user_id = id, user_id
  end

end