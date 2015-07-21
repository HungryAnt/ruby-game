require_relative 'player_service'
require_relative 'lv_service'

class GameManager
  @@player_service = PlayerService.new

  def self.player_service
    @@player_service
  end

  @@lv_service = LvService.new

  def self.lv_service
    @@lv_service
  end
end