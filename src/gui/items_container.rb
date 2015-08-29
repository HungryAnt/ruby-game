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

    def mouse_left_button_down(x, y)
      @items.each do |control|
        return true if control.mouse_left_button_down(x, y)
      end
      super(x, y)
    end
  end
end