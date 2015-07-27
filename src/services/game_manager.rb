require_relative 'player_service'
require_relative 'lv_service'

class GameManager
  @@lv_service = LvService.new

  def self.lv_service
    @@lv_service
  end
end