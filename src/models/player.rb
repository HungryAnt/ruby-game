require_relative 'hp'
require_relative 'exp'

class Player
  include Hp
  include Exp

  def initialize
    init_hp
    init_exp
    puts @hp
  end
end