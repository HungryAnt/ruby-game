$:.unshift(File.dirname(__FILE__))

require 'gosu'
require 'utils/media_util'
require 'z_order'
require 'engine/direction'
require 'engine/animation'
require 'engine/animation_holder'
require 'engine/animation_container'
require 'engine/animation_util'
require 'engine/animation_manager'

require 'models/food'
require 'models/player'
require 'models/tiles'

require 'services/song_manager'
require 'services/map_manager'
require 'services/game_manager'

require 'modelviews/player_view_model'
require 'modelviews/area_view_model'
require 'modelviews/map_view_model'
require 'modelviews/food_view_model'

require 'views/view_base'
require 'views/status_bar_view'
require 'views/game_map_view'
require 'views/map_editor_view'
require 'views/main_window'

require 'config/game_config'
require 'config/anim_config'
require 'config/map_config'

window = MainWindow.new
window.show