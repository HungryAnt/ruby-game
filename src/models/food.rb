require_relative 'location'
require_relative 'visible'

class Food
  include Location
  include Visible

  attr_accessor :eating

  def initialize(x, y)
    init_location x, y
    init_visible
    @eating = false
  end

  def eatable?
    true
  end
end