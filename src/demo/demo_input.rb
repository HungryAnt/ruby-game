require 'gosu'

class DemoInputWindow < Gosu::Window
  def initialize
    super 300, 300, fullscreen:false, update_interval:1000/40
    self.caption = 'Demo Input'
    input = Gosu::TextInput.new
    input.caret_pos = 0
    input.selection_start = 0

    self.text_input = input
  end


  def update

  end

  def button_down(id)

  end

  def needs_cursor?
    true
  end
end

DemoInputWindow.new.show