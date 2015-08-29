class A
  def initialize
    puts 'A'
  end
end

class B < A
  def initialize
    super()
  end
end

B.new