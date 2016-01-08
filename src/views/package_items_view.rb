# coding: UTF-8

class PackageItemsView
  attr_accessor :visible

  ROW_COUNT = 7
  COL_COUNT = 6

  PROMPT_HEIGHT = 30
  ITEM_WIDTH = 50
  ITEM_HEIGHT = 50
  MARGIN = 5
  PADDING = 10

  LEFT_TAB_ITEM_WIDTH = 70
  LEFT_TAB_ITEM_HEIGHT = 20
  LEFT_TAB_ITEM_MARGIN = 5

  def initialize(window, package_items_vm)
    autowired(WindowResourceService)
    @window = window
    @package_items_vm = package_items_vm
    @visible = false
    @prompt_font = @window_resource_service.get_normal_font
    init_controls
  end

  def draw
    return unless @visible
    @dialog.draw
  end

  def button_down(id)
    return false unless @visible
    case id
      when Gosu::MsLeft, Gosu::MsRight
        mouse_x, mouse_y = @window.mouse_x, @window.mouse_y
        if @dialog.contains_point?(mouse_x, mouse_y)
          if id == Gosu::MsLeft
            @dialog.mouse_left_button_down(mouse_x, mouse_y)
          else
            # @dialog.mouse_right_button_down(mouse_x, mouse_y)
          end
        else
          @visible = false
        end
        return true
    end
    false
  end

  def init_controls
    dialog_width = LEFT_TAB_ITEM_WIDTH + ITEM_WIDTH * COL_COUNT + MARGIN * (COL_COUNT - 1) + PADDING * 2
    dialog_height = PROMPT_HEIGHT + MARGIN + ITEM_HEIGHT * ROW_COUNT + MARGIN * (ROW_COUNT - 1) + PADDING * 2

    dialog_left, dialog_top = (GameConfig::WHOLE_WIDTH - dialog_width) / 2, (GameConfig::WHOLE_HEIGHT - dialog_width) / 2
    @dialog = AntGui::Dialog.new(dialog_left, dialog_top, dialog_width, dialog_height)
    @dialog.background_color = 0x88_A17038
    main_panel = AntGui::Canvas.new
    left_panel = AntGui::Canvas.new
    right_panel = AntGui::Control.new

    AntGui::Canvas.set_canvas_props left_panel, 0, 0, LEFT_TAB_ITEM_WIDTH, dialog_height
    AntGui::Canvas.set_canvas_props right_panel, LEFT_TAB_ITEM_WIDTH, 0,
                                    dialog_width - LEFT_TAB_ITEM_WIDTH, dialog_height

    main_panel.add left_panel
    main_panel.add right_panel

    rubbish_panel = init_rubbish_panel
    nutrient_panel = init_nutrient_panel
    vehicle_panel = init_vehicle_panel
    eye_wear_panel = init_equipment_eye_wear
    wing_panel = init_equipment_wing
    hat_panel = init_equipment_hat
    pet_panel = init_pet_panel

    right_panel.content = rubbish_panel

    # 左侧tab
    rubbish_tab = AntGui::TextBlock.new(@prompt_font, '  垃圾')
    nutrient_tab = AntGui::TextBlock.new(@prompt_font, '  物资')
    vehicle_tab = AntGui::TextBlock.new(@prompt_font, '  载具')
    eye_wear_tab = AntGui::TextBlock.new(@prompt_font, '  眼部饰品')
    wing_tab = AntGui::TextBlock.new(@prompt_font, '  翅膀')
    hat_tab = AntGui::TextBlock.new(@prompt_font, '  帽子/头盔')
    pet_tab = AntGui::TextBlock.new(@prompt_font, '  萌宠!')

    all_tabs = [rubbish_tab, nutrient_tab, vehicle_tab, eye_wear_tab, wing_tab, hat_tab, pet_tab]

    rubbish_tab.background_color = 0x88_FFFFFF

    parent_panel = right_panel

    init_tab_event = Proc.new do |item_tab, tab_related_panel|
      item_tab.on_mouse_left_button_down do
        all_tabs.each { |tab| set_unselected_tab_color tab }
        set_selected_tab_color item_tab
        parent_panel.content = tab_related_panel
        @dialog.update_arrange
      end
    end

    init_tab_event.call rubbish_tab, rubbish_panel
    init_tab_event.call nutrient_tab, nutrient_panel
    init_tab_event.call vehicle_tab, vehicle_panel
    init_tab_event.call eye_wear_tab, eye_wear_panel
    init_tab_event.call wing_tab, wing_panel
    init_tab_event.call hat_tab, hat_panel
    init_tab_event.call pet_tab, pet_panel

    all_tabs.each { |tab| left_panel.add tab }

    y = 10
    all_tabs.each do |tab|
      AntGui::Canvas.set_canvas_props tab, 0, y, LEFT_TAB_ITEM_WIDTH, LEFT_TAB_ITEM_HEIGHT
      y += LEFT_TAB_ITEM_HEIGHT + LEFT_TAB_ITEM_MARGIN
    end

    @dialog.content = main_panel
    @dialog.update_arrange
  end

  private

  def set_unselected_tab_color(tab)
    tab.background_color = 0x00_FFFFFF
  end

  def set_selected_tab_color(tab)
    tab.background_color = 0x88_FFFFFF
  end

  def init_rubbish_panel
    rubbishes = @package_items_vm.get_rubbishes
    items = rubbishes.map do |rubbish_info|
      {
          data: nil,
          content: create_rubbish_content(rubbish_info[:rubbish_type_id],
                                          rubbish_info[:count])
      }
    end
    create_panel('辛辛苦苦收集的垃圾，可以换成钱币呢', items) do |item|
      @visible = false
    end
  end

  def create_rubbish_content(rubbish_type_id, count)
    image = RubbishTypeInfo.get_image(rubbish_type_id)
    MultiItemsControl.new(image, count)
  end

  def init_nutrient_panel
    nutrients = @package_items_vm.get_nutrients
    items = nutrients.map do |nutrient_info|
      {
          data: nil,
          content: create_nutrient_content(nutrient_info[:nutrient_type_id],
                                           nutrient_info[:count])
      }
    end
    create_panel('珍贵的物资，兑换货币或者囤积起来留作他用', items) do |item|
      @visible = false
    end
  end

  def create_nutrient_content(nutrient_type_id, count)
    image = NutrientTypeInfo.get_image nutrient_type_id
    MultiItemsControl.new(image, count)
  end

  def init_vehicle_panel
    vehicles = @package_items_vm.get_vehicles
    items = vehicles.map do |vehicle|
      {
          data: vehicle,
          content: create_equipment_content(vehicle)
      }
    end
    create_panel('点击切换载具，Q键上下车', items) do |item|
      @package_items_vm.choose_equipment item[:data]
      @visible = false
    end
  end

  def init_equipment_eye_wear
    init_common_equipment_panel '眼部饰品', Equipment::Type::EYE_WEAR, :get_eye_wears
  end

  def init_equipment_wing
    init_common_equipment_panel '翅膀', Equipment::Type::WING, :get_wings
  end

  def init_equipment_hat
    init_common_equipment_panel '帽子', Equipment::Type::HAT, :get_hats
  end

  def init_common_equipment_panel(prompt_text, equipment_type, query_method)
    equipments = @package_items_vm.send query_method
    items = equipments.map do |equipment|
      {
          type: :equipment,
          data: equipment,
          content: create_equipment_content(equipment)
      }
    end
    none_equipment = {
        type: :none_equipment,
        data: equipment_type,
        content: create_empty_equipment_content
    }
    items.insert 0, none_equipment


    create_panel(prompt_text, items) do |item|
      if item[:type] == :none_equipment
        # 卸下装备
        @package_items_vm.choose_none_equipment item[:data]
      else
        @package_items_vm.choose_equipment item[:data]
      end
      @visible = false
    end
  end

  def create_equipment_content(equipment)
    image = EquipmentDefinition.get_item_image(equipment.key)
    AntGui::Image.new(image)
  end

  def create_empty_equipment_content
    text_block = AntGui::TextBlock.new @prompt_font, '空', :center, :center
    text_block.foreground_color = 0xDD_BBBBBB
    control = AntGui::Control.new
    control.content = text_block
    control
  end

  def init_pet_panel
    pets = @package_items_vm.get_pets
    items = pets.map do |pet|
      {
          data: pet,
          content: create_pet_content(pet)
      }
    end
    create_panel('点击召唤宠物，W键收起宠物', items) do |item|
      @package_items_vm.choose_pet item[:data]
      @visible = false
    end
  end

  def create_pet_content(pet)
    image = EquipmentDefinition.get_item_image(pet.pet_type)
    AntGui::Image.new(image)
  end

  def create_panel(prompt_text, items, &on_item_select)
    canvas = AntGui::Canvas.new
    prompt_text_block = AntGui::TextBlock.new(@prompt_font, prompt_text)
    prompt_text_block.background_color = 0x88_FFFFFF
    canvas.add prompt_text_block
    AntGui::Canvas.set_canvas_props(prompt_text_block, PADDING, PADDING,
                                    ITEM_WIDTH * COL_COUNT + MARGIN * (COL_COUNT - 1), PROMPT_HEIGHT)
    0.upto(ROW_COUNT * COL_COUNT - 1) do |index|
      row = index / COL_COUNT
      col = index % COL_COUNT
      item_left = PADDING + (ITEM_WIDTH + MARGIN) * col
      item_top = PADDING + (ITEM_HEIGHT + MARGIN) * row + PROMPT_HEIGHT + MARGIN
      control = AntGui::Control.new
      control.set(AntGui::Canvas::LEFT, item_left)
      control.set(AntGui::Canvas::TOP, item_top)
      control.set(AntGui::Canvas::WIDTH, ITEM_WIDTH)
      control.set(AntGui::Canvas::HEIGHT, ITEM_HEIGHT)
      control.background_color = 0xFF_2B2B2B

      if index < items.count
        item = items[index]
        content = item[:content]
        control.content = content
        content.on_mouse_left_button_down do
          on_item_select.call(item)
        end
      end

      canvas.add(control)
    end
    canvas
  end
end