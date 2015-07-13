require_relative 'location'
require_relative 'hp'
require_relative 'exp'
require_relative 'package'

class Player
  include Location
  include Hp
  include Exp

  attr_reader :package

  def initialize(x, y)
    init_location x, y
    init_hp
    init_exp

    @package = Package.new 100
  end
end