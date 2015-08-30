module AntGui
  class Canvas < ItemsContainer
    LEFT = :left
    TOP = :top
    WIDTH = :width
    HEIGHT = :height

    def arrange(left, top, width, height)
      super
      @items.each do |control|
        control.arrange(left + control.get(LEFT), top + control.get(TOP),
                        control.get(WIDTH), control.get(HEIGHT))
      end
    end
  end
end
