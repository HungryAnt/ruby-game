require_relative 'location'

class Food
  include Location

  def initialize(x, y)
    init_location x, y
  end

  def eatable?
    true
  end
end