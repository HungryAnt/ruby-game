# coding: UTF-8
require 'gosu'
require 'z_order'
require 'modelviews/player'

class MainWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 500

  def initialize
    super WIDTH, HEIGHT
    self.caption = '我的世界'
    @bg_image = Gosu::Image.new("media/img/ground/001.jpg", :tileable => true)
    @bg_scale_x = WIDTH * 1.0 / @bg_image.width
    @bg_scale_y = HEIGHT * 1.0 / @bg_image.height

    @player = Player.new(100, 80)
  end

  def update

  end

  def draw
    @bg_image.draw(0, 0, ZOrder::Background, @bg_scale_x, @bg_scale_y)
    @player.draw
  end
end

