require_relative 'hp'
require_relative 'exp'

class Player
  include Hp
  include Exp

  def initialize
    super
  end
end