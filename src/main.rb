# coding: UTF-8
$:.unshift(File.dirname(__FILE__))
@base_src_dir = File.dirname(__FILE__)

require 'gosu'
require 'utils/media_util'

MediaUtil.init_base_media_path(File.join(@base_src_dir, '../media'))

require 'z_order'
require 'engine/direction'
require 'engine/animation'
require 'engine/animation_holder'
require 'engine/animation_container'
require 'engine/animation_util'
require 'engine/animation_manager'

require 'models/area'
require 'models/food'
require 'models/role'
require 'models/tiles'

require 'services/song_manager'
require 'services/map_manager'
require 'services/game_manager'
require 'services/food_factory'

require 'viewmodels/item_view_model'
require 'viewmodels/player_view_model'
require 'viewmodels/area_view_model'
require 'viewmodels/map_view_model'
require 'viewmodels/food_view_model'

require 'views/view_base'
require 'views/status_bar_view'
require 'views/game_map_view'
require 'views/map_editor_view'
require 'views/main_window'

require 'config/game_config'
require 'config/anim_config'
require 'config/map_config'
require 'config/food_config'

window = MainWindow.new
window.show