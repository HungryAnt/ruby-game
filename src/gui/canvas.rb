module AntGui
  class Canvas < ItemsContainer
    LEFT = :left
    TOP = :top
    WIDTH = :width
    HEIGHT = :height

    def initialize
      super()

      if block_given?
        items = yield
        items.each { |item| add(item) }
      end
    end

    def arrange(left, top, width, height)
      super
      @items.each do |control|
        control.arrange(left + control.get(LEFT), top + control.get(TOP),
                        control.get(WIDTH), control.get(HEIGHT))
      end
    end

    def self.set_canvas_props(control, left, top, width, height)
      control.set(AntGui::Canvas::LEFT, left)
      control.set(AntGui::Canvas::TOP, top)
      control.set(AntGui::Canvas::WIDTH, width)
      control.set(AntGui::Canvas::HEIGHT, height)
    end
  end
end
