module GameElement
    attr_accessor :name
end

class GameItem
    include GameElement
    attr_reader :description
end

module Level
    attr_reader :level

    def initialize
        @level = 0
    end

    def level_up
        @level += 1
    end
end