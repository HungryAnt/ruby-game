require_relative 'player_service'

class GameManager
  @@player_service = PlayerService.new

  def self.player_service
    @@player_service
  end
end