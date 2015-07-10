$:.unshift(File.dirname(__FILE__))

require 'gosu'
require 'utils/media_util'
require 'z_order'
require 'control'

require 'modelviews/player'
require 'modelviews/ground'
require 'modelviews/food'

require 'views/main_window'

window = MainWindow.new
window.show