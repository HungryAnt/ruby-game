class PlayerService
  attr_reader :player

  def initialize
    @player = Player.new
  end
end