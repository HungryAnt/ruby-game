require_relative 'game_element'

class Banana < GameItem
  def initialize
    @name = "香蕉"
    @description = "食物"
  end
end

class Cup < GemeItem
  def initialize
    @name = '杯子'
    @description = '容器，适合装水'
  end
end

banana = Banana.new

puts banana.name, banana.description