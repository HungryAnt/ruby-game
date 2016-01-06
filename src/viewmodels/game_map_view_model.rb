class GameMapViewModel
  attr_reader :package_items_view_model

  include GameMouse
  include GameRole
  include GameMap
  include GamePet
  include GameAreaItems
  include GameLargeRubbish
  include GameMonster

  def initialize
    autowired(PlayerService, CommunicationService, MapService,
              GameRolesCommunicationHandler, PetCommunicationHandler,
              AreaItemsService, NetworkService,
              LargeRubbishesService, MonstersService, UserService,
              WindowResourceService)
  end

  def init
    init_mouse
    init_roles
    init_map
    init_pets
    init_area_items
    init_large_rubbishes
    init_monsters
    @package_items_view_model = PackageItemsViewModel.new(@player_view_model)
    @update_times = 0
    @visual_items = []
  end

  def update
    @map_service.update_map
    get_current_area.update_area_scroll_view *@player_view_model.actual_role_location

    area = get_current_area.area

    process_role_vms do |role_vm|
      role_vm.auto_move area
      role_vm.update_eating_food
      role_vm.update_state
      role_vm.update
    end

    @player_view_model.update area

    travel_other_pet_vms do |pet_vm|
      pet_vm.update area
    end

    travel_monsters do |monster_vm|
      monster_vm.update area, @player_view_model
    end

    sort_visual_items

    goto_area
    @update_times += 1
  end

  def sort_visual_items
    @visual_items = []
    process_role_vms { |role_vm| @visual_items << role_vm }
    get_large_rubbish_vms.each { |large_rubbish_vm| @visual_items << large_rubbish_vm }
    get_monster_vms.each { |monster_vm| @visual_items << monster_vm }
    get_current_area.visual_element_vms.each { |element_vm| @visual_items << element_vm }
    @player_view_model.pets_vms.each { |pet_vm| @visual_items << pet_vm }
    travel_other_pet_vms { |pet_vm| @visual_items << pet_vm }
    get_item_vms.each { |item_vm| @visual_items << item_vm }

    @visual_items.sort_by! { |item| item.y }
  end

  def draw
    @map_service.draw_map *@player_view_model.actual_role_location
    # get_item_vms.each { |item_vm| item_vm.draw }

    additional_equipment_vm = get_current_area.additional_equipment_vm
    auto_scale_info = get_current_area.auto_scale_info

    Gosu::translate(*get_current_area.get_area_offset) {
      @visual_items.each do |item|
        if item.respond_to? :draw_with_area_addition
          item.draw_with_area_addition additional_equipment_vm, auto_scale_info
        else
          item.draw auto_scale_info
        end
      end
    }
  end

  def needs_cursor?
    false
  end

  def command(cmd)
    user_id = @player_service.user_id
    @communication_service.command cmd.chomp('`'), user_id, get_current_map.id, get_current_area.id.to_s
  end

end