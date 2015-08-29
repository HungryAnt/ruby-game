module AntGui
  class ItemsContainer < Container
    attr_reader :items

    def initialize
      @items = []
    end

    def add(control)
      @items << control
    end

    def delete(control)
      @items.delete control
    end

    def draw
      @items.each {|control| control.draw}
    end
  end
end