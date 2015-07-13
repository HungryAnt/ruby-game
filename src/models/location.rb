module Location
  attr_accessor :x, :y

  private
  def init_location(x, y)
    @x, @y = x, y
  end
end