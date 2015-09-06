module AntGui
  class ItemsContainer < Container
    attr_reader :items

    def initialize
      super()
      @items = []
    end

    def add(control)
      @items << control
    end

    def delete(control)
      @items.delete control
    end

    def do_draw(z)
      @items.each {|control| control.draw z}
    end

    def mouse_left_button_down(x, y)
      @items.reverse_each do |control|
        return true if control.mouse_left_button_down(x, y)
      end
      super
    end

    def mouse_move(x, y)
      @items.reverse_each do |control|
        control.mouse_move(x, y) unless control.nil?
      end
      super
    end
  end
end