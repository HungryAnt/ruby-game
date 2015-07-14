class PlayerService
  attr_reader :player

  def initialize
    @player = Role.new(100, 300)
  end
end