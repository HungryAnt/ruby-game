# coding: UTF-8
require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480 #, :fullscreen=>true
    self.caption = '有点意思'
  end

  def update
  end

  def draw
  end
end

window = GameWindow.new
window.show