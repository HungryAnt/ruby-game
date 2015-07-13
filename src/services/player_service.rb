class PlayerService
  attr_reader :player

  def initialize
    @player = Player.new(100, 300)
  end
end