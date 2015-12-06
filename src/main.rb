# coding: UTF-8
$:.unshift(File.dirname(__FILE__))
@base_src_dir = File.dirname(__FILE__)

require 'json'

require 'gosu'
require 'securerandom'
require 'config/network_config'

require 'utils/media_util'
require 'utils/graphics_util'
require 'utils/level_util'
require 'utils/des'
require 'utils/character_util'
require 'utils/string_util'
require 'utils/new_work_util'

require 'gui/gui'
require 'http/http_client'

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

require 'models/location'
require 'models/hp'
require 'models/exp'
require 'models/package'
require 'models/movable'
require 'models/vehicle'
require 'models/area'
require 'models/item'
require 'models/food'
require 'models/rubbish'
require 'models/rubbish_bin'
require 'models/nutrient'
require 'models/nutrient_bin'
require 'models/large_rubbish'
require 'models/role_equipment'
require 'models/pet_type_info'
require 'models/pet'
require 'models/monster'
require 'models/hit_type_definition'
require 'models/role_type'
require 'models/role'
require 'models/tiles'
require 'models/equipment'
require 'models/map_type'
require 'models/area_visual_element'

require 'entity/goods'
require 'entity/page_result'

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
require 'messages/map_user_count_message'
require 'messages/smash_large_rubbish_message'
require 'messages/large_rubbish_message'
require 'messages/area_large_rubbishes_query_message'
require 'messages/inc_exp_message'
require 'messages/collecting_nutrient_message'
require 'messages/pet_message'

require 'clients/yecai_web_client'

require 'services/http_client_factory'
require 'services/equipment_definition'
require 'services/role_type_definition'

require 'services/song_service'
require 'services/map_service'
require 'services/message_handler_service'
require 'services/game_roles_communication_handler'
require 'services/pet_communication_handler'
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
require 'services/anti_cheating_service'
require 'services/user_equipment_service'
require 'services/large_rubbishes_service'
require 'services/hit_service'

require 'viewmodels/item_view_model'
require 'viewmodels/pet_view_model'
require 'viewmodels/monster_view_model'
require 'viewmodels/player_pet_view_model'
require 'viewmodels/role_view_model'
require 'viewmodels/player_view_model'
require 'viewmodels/area_view_model'
require 'viewmodels/map_view_model'
require 'viewmodels/food_view_model'
require 'viewmodels/rubbish_view_model'
require 'viewmodels/nutrient_view_model'
require 'viewmodels/mouse_view_model'
require 'viewmodels/chat_board_view_model'

require 'viewmodels/game_modules/game_mouse'
require 'viewmodels/game_modules/game_role'
require 'viewmodels/game_modules/game_map'
require 'viewmodels/game_modules/game_area_items'
require 'viewmodels/game_modules/game_large_rubbish'
require 'viewmodels/game_modules/game_pet'
require 'viewmodels/game_modules/game_monster'

require 'viewmodels/game_map_view_model'
require 'viewmodels/item_view_model_factory'
require 'viewmodels/vehicle_view_model'
require 'viewmodels/equipment_view_model'
require 'viewmodels/equipment_view_model_factory'
require 'viewmodels/package_items_view_model'
require 'viewmodels/chat_bubble_view_model'
require 'viewmodels/shopping_view_model'
require 'viewmodels/large_rubbish_view_model'
require 'viewmodels/large_rubbish_view_model_factory'
require 'viewmodels/ui_control_view_model'
require 'viewmodels/area_visual_element_view_model'

require 'views/control/multi_items_control'
require 'views/control/shopping_item_control'

require 'views/view_base'
require 'views/chat_board_view'
require 'views/actions_bar_view'
require 'views/status_bar_view'
require 'views/game_map_view'
require 'views/map_editor_view'
require 'views/user_creation_view'
require 'views/loading_view'
require 'views/package_items_view'
require 'views/channel_main_view'
require 'views/shopping_view'
require 'views/main_window'
require 'views/startup_loading_window'
require 'views/startup_args_error_window'

require 'application'
app = Application.new

if !app.validate_args
  app.show_startup_error
else
  app.startup do
    require 'config/anim_config'
    require 'config/pet_anim_config'
    require 'config/monster_anim_config'
    require 'config/role_anim_config'
    require 'config/map_anim_config'
    require 'config/equipment_config'
    require 'config/equipment_vehicle_config'
    require 'config/equipment_eye_wear_config'
    require 'config/food_config'
    require 'config/rubbish_config'
    require 'config/nutrient_config'
    require 'config/large_rubbish_config'
    require 'config/map_config'
    require 'config/role_config'
    require 'config/pet_config'
  end

  if GameConfig::USER_DEBUG
    ARGV=[SecureRandom.uuid, 'window']
  end

  user_id, screen_mode = ARGV[0], ARGV[1]
  app.init user_id, screen_mode
  app.run
end
