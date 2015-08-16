# coding: UTF-8
$:.unshift(File.dirname(__FILE__))
@base_src_dir = File.dirname(__FILE__)

require 'json'

require 'gosu'
require 'utils/media_util'
require 'utils/graphics_util'
require 'utils/level_util'

MediaUtil.init_base_media_path(File.join(@base_src_dir, '../media'))

require 'engine/dependency_injection'

require 'config/game_config'

require 'z_order'
require 'engine/image'
require 'engine/direction'
require 'engine/animation'
require 'engine/animation_holder'
require 'engine/animation_container'
require 'engine/animation_util'
require 'engine/animation_manager'

require 'models/area'
require 'models/item'
require 'models/food'
require 'models/role'
require 'models/tiles'

require 'messages/join_message'
require 'messages/quit_message'
require 'messages/chat_message'
require 'messages/system_message'
require 'messages/role_message'
require 'messages/roles_query_message'

require 'services/song_service'
require 'services/map_service'
require 'services/food_factory'
require 'services/message_handler_service'
require 'services/game_roles_service'
require 'services/area_items_service'
require 'services/chat_service'
require 'services/network_service'
require 'services/user_service'
require 'services/player_service'

require 'viewmodels/item_view_model'
require 'viewmodels/role_view_model'
require 'viewmodels/player_view_model'
require 'viewmodels/area_view_model'
require 'viewmodels/map_view_model'
require 'viewmodels/food_view_model'
require 'viewmodels/mouse_view_model'
require 'viewmodels/chat_board_view_model'
require 'viewmodels/game_map_view_model'

require 'views/view_base'
require 'views/chat_board_view'
require 'views/status_bar_view'
require 'views/game_map_view'
require 'views/map_editor_view'
require 'views/user_creation_view'
require 'views/main_window'

require 'config/anim_config'
require 'config/map_config'
require 'config/food_config'
require 'config/network_config'

require 'application'

app = Application.new
app.init
app.run