# coding: UTF-8
$:.unshift(File.dirname(__FILE__))
@base_src_dir = File.dirname(__FILE__)

require 'json'

require 'gosu'
require 'config/network_config'

require 'utils/media_util'
require 'utils/graphics_util'
require 'utils/level_util'
require 'utils/des'
require 'utils/character_util'
require 'utils/string_util'
require 'utils/new_work_util'

require 'gui/gui'

MediaUtil.init_base_media_path(File.join(Dir::pwd, 'media'))

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
require 'models/rubbish'
require 'models/rubbish_bin'
require 'models/role_equipment'
require 'models/role'
require 'models/tiles'
require 'models/equipment'
require 'models/map_type'

require 'entity/goods'

require 'messages/init_sync_user_message'
require 'messages/res_sync_user_message'
require 'messages/update_lv_message'
require 'messages/join_message'
require 'messages/quit_message'
require 'messages/chat_message'
require 'messages/system_message'
require 'messages/role_message'
require 'messages/roles_query_message'
require 'messages/area_item_message'
require 'messages/area_items_query_message'
require 'messages/try_pickup_item_message'
require 'messages/discard_item_message'
require 'messages/eating_food_message'
require 'messages/eat_up_food_message'
require 'messages/command_message'
require 'messages/hit_message'
require 'messages/being_battered_message'
require 'messages/collecting_rubbish_message'

require 'services/equipment_definition'
require 'services/role_type_definition'

require 'services/song_service'
require 'services/map_service'
require 'services/food_factory'
require 'services/message_handler_service'
require 'services/game_roles_service'
require 'services/area_items_service'
require 'services/communication_service'
require 'services/network_service'
require 'services/user_service'
require 'services/player_service'
require 'services/des_service'
require 'services/window_resource_service'
require 'services/account_service'
require 'services/shopping_service'
require 'services/map_user_count_service'

require 'viewmodels/item_view_model'
require 'viewmodels/role_view_model'
require 'viewmodels/player_view_model'
require 'viewmodels/area_view_model'
require 'viewmodels/map_view_model'
require 'viewmodels/food_view_model'
require 'viewmodels/rubbish_view_model'
require 'viewmodels/mouse_view_model'
require 'viewmodels/chat_board_view_model'
require 'viewmodels/game_map_view_model'
require 'viewmodels/item_view_model_factory'
require 'viewmodels/vehicle_view_model'
require 'viewmodels/equipment_view_model_factory'
require 'viewmodels/package_items_view_model'
require 'viewmodels/chat_bubble_view_model'
require 'viewmodels/shopping_view_model'

require 'views/control/rubbish_item_control'

require 'views/view_base'
require 'views/chat_board_view'
require 'views/status_bar_view'
require 'views/game_map_view'
require 'views/map_editor_view'
require 'views/user_creation_view'
require 'views/loading_view'
require 'views/package_items_view'
require 'views/channel_main_view'
require 'views/shopping_view'
require 'views/main_window'

require 'config/anim_config'
require 'config/equipment_vehicle_config'
require 'config/equipment_config'
require 'config/map_config'
require 'config/food_config'
require 'config/rubbish_config'
require 'config/role_config'

require 'application'

app = Application.new
app.init
app.run