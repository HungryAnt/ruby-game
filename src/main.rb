$:.unshift(File.dirname(__FILE__))

require 'gosu'
require 'utils/media_util'
require 'z_order'
require 'engine/direction'
require 'engine/animation'
require 'engine/song_manager'
require 'engine/map_manager'

require 'modelviews/player'
require 'modelviews/area'
require 'modelviews/map'
require 'modelviews/food'

require 'views/main_window'

require 'config/game_config'
require 'config/map_config'

window = MainWindow.new
window.show