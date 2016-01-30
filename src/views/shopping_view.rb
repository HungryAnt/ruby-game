# coding: UTF-8
class ShoppingView < ViewBase
  GOODS_ITEM_WIDTH = 110
  GOODS_ITEM_HEIGHT = 95 + 5 + 25
  GOODS_IMAGE_HEIGHT = 95
  GOODS_PAY_BUTTON_HEIGHT = 25

  PREVIEW_X = 590
  PREVIEW_Y = 260
  PREVIEW_BUTTON_HEIGHT = 25
  PREVIEW_BUTTON_WIDTH = 50
  PREVIEW_DIRECTION_MARGIN = 60
  PREVIEW_BUTTON_NORMAL_BACK = 0x88_86C7EF
  PREVIEW_BUTTON_HOVER_BACK = 0xA8_A6E7FF

  GOODS_PADDING = 10
  GOODS_MARGIN = 10
  GOODS_ROW_COUNT = 3
  GOODS_COL_COUNT = 3

  COLOR_MAIN_BACK_1 = 0xFF_3878A0 # 0xFF_906838
  COLOR_MAIN_BACK_2 = 0xFF_104977 # 0xFF_C0A068

  COLOR_GOODS_BACK = 0xFF_142935 # 0xFF_382915
  COLOR_GOODS_ITEM_BACK = 0x44_EADAC5

  COLOR_BUTTON_FORE = 0xFF_182228 # 0xFF_662230
  COLOR_BUTTON_NORMAL_BACK = 0xFF_6AB6E2 # 0xFF_E8B455
  COLOR_BUTTON_HOVER_BACK = 0xFF_86C7EF #0xFF_FFE586

  COLOR_BTN_BUY_EXIST_FORE = 0xFF_1F3349
  COLOR_BTN_BUY_EXIST_BACK = 0xFF_3A5260

  COLOR_BTN_BUY_NEW_FORE = 0xFF_1F3349
  COLOR_BTN_BUY_NEW_BACK = 0xFF_4694C4

  COLOR_BOTTOM_BAR_BACK_1 = 0xFF_FEFEFE
  COLOR_BOTTOM_BAR_BACK_2 = 0xFF_DBDBDB
  COLOR_MONEY_FORE = 0xFF_905810

  COLOR_PAGE_NO = 0xFF_BCD6E5 # 0xFF_662230

  def initialize(window)
    super
    autowired(WindowResourceService, AccountService, UserService, ShoppingViewModel)
    init_money
    @font = @window_resource_service.get_font 20
    @page_no = @total_page_count = 1
    @current_goods_type = Equipment::Type::VEHICLE
    init_role_view
  end

  def init_role_view
    role = Role.new @user_service.user_name, @user_service.role_type, PREVIEW_X, PREVIEW_Y
    @role_preview = RoleViewModel.new role
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def update_ui
    items, page_count = @shopping_view_model.get_goods @current_goods_type, @page_no
    @total_page_count = page_count
    create_ui items
  end

  def create_ui(items)
    @dialog = AntGui::Dialog.new(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT)
    main_canvas = AntGui::Canvas.new
    @dialog.content = main_canvas

    tab_panel_left = 30
    tab_panel_top = 20
    tab_panel_width = GOODS_ITEM_WIDTH * GOODS_COL_COUNT + GOODS_MARGIN * (GOODS_COL_COUNT - 1) + GOODS_PADDING * 2
    tab_panel_height = 32
    goods_panel_left = tab_panel_left
    goods_panel_top = 100
    goods_panel_width = tab_panel_width
    goods_panel_height = GOODS_ITEM_HEIGHT * GOODS_ROW_COUNT + GOODS_MARGIN * (GOODS_ROW_COUNT - 1) + GOODS_PADDING * 2
    page_panel_left = goods_panel_left
    page_panel_top = goods_panel_top + goods_panel_height + 12
    page_panel_width = goods_panel_width
    page_panel_height = 32
    right_panel_left = goods_panel_left + goods_panel_width + 80
    right_panel_top = goods_panel_top
    right_panel_width = 250
    right_panel_height = goods_panel_height + 12 + page_panel_height

    tab_panel = create_tab_panel tab_panel_left, tab_panel_top, tab_panel_width, tab_panel_height
    goods_panel = create_goods_panel items, goods_panel_left, goods_panel_top, goods_panel_width, goods_panel_height
    page_panel = create_page_panel page_panel_left, page_panel_top, page_panel_width, page_panel_height
    right_panel = create_right_panel right_panel_left, right_panel_top, right_panel_width, right_panel_height

    main_canvas.add tab_panel
    main_canvas.add goods_panel
    main_canvas.add page_panel
    main_canvas.add right_panel

    # 预览按钮
    clear_button = create_button '裸体', PREVIEW_BUTTON_NORMAL_BACK, PREVIEW_BUTTON_HOVER_BACK
    AntGui::Canvas.set_canvas_props clear_button, PREVIEW_X - PREVIEW_BUTTON_WIDTH / 2,
                                    PREVIEW_Y + 40, PREVIEW_BUTTON_WIDTH, PREVIEW_BUTTON_HEIGHT
    clear_button.on_mouse_left_button_down do
      @role_preview.un_equip_all
    end

    # 左侧按钮 角色向右转
    left_button = create_button '旋转', PREVIEW_BUTTON_NORMAL_BACK, PREVIEW_BUTTON_HOVER_BACK
    AntGui::Canvas.set_canvas_props left_button, PREVIEW_X - 110 - PREVIEW_BUTTON_WIDTH / 2 ,
                                    PREVIEW_Y - PREVIEW_BUTTON_HEIGHT / 2, PREVIEW_BUTTON_WIDTH, PREVIEW_BUTTON_HEIGHT
    left_button.on_mouse_left_button_down do
      @role_preview.turn_right
    end

    # 右侧按钮 角色向左转
    right_button = create_button '旋转', PREVIEW_BUTTON_NORMAL_BACK, PREVIEW_BUTTON_HOVER_BACK
    AntGui::Canvas.set_canvas_props right_button, PREVIEW_X + 110 - PREVIEW_BUTTON_WIDTH / 2,
                                    PREVIEW_Y - PREVIEW_BUTTON_HEIGHT / 2, PREVIEW_BUTTON_WIDTH, PREVIEW_BUTTON_HEIGHT
    right_button.on_mouse_left_button_down do
      @role_preview.turn_left
    end

    main_canvas.add clear_button
    main_canvas.add left_button
    main_canvas.add right_button

    @dialog.update_arrange
  end

  def create_tab_panel(left, top, width, height)
    tab_panel = AntGui::Canvas.new
    AntGui::Canvas.set_canvas_props tab_panel, left, top, width, height
    x = y = 0
    tab_item_width = 88
    tab_item_height = height
    tab_item_margin = 5

    create_button_proc = Proc.new do |text, equipment_type|
      # category = StringUtil.underline_to_camel equipment_type.to_s

      button = create_button text
      AntGui::Canvas.set_canvas_props button, x, y, tab_item_width, tab_item_height
      button.on_mouse_left_button_down do
        @page_no = 1
        @current_goods_type = equipment_type
        update_ui
      end
      tab_panel.add button

      x += tab_item_width + tab_item_margin
      if x >= GameConfig::WHOLE_WIDTH - left * 2
        x = 0
        y += tab_item_height + tab_item_margin
      end
    end

    create_button_proc.call '载具', Equipment::Type::VEHICLE
    create_button_proc.call '宠物', :pet
    create_button_proc.call '底盘', Equipment::Type::UNDERPAN
    create_button_proc.call '翅膀', Equipment::Type::WING
    create_button_proc.call '帽子/头盔', Equipment::Type::HAT
    create_button_proc.call '眼部饰品', Equipment::Type::EYE_WEAR
    create_button_proc.call '耳部饰品', Equipment::Type::EAR_WEAR
    create_button_proc.call '手持物', Equipment::Type::HANDHELD

    tab_panel
  end

  def create_goods_panel(items, goods_panel_left, goods_panel_top, goods_panel_width, goods_panel_height)
    goods_panel = AntGui::Canvas.new
    AntGui::Canvas.set_canvas_props goods_panel, goods_panel_left, goods_panel_top,
                                    goods_panel_width, goods_panel_height
    goods_panel.background_color = COLOR_GOODS_BACK
    index = 0
    0.upto(GOODS_ROW_COUNT - 1).each do |row|
      0.upto(GOODS_COL_COUNT - 1).each do |col|
        if index < items.size
          item = items[index]
          item_left = GOODS_PADDING + (GOODS_ITEM_WIDTH + GOODS_MARGIN) * col
          item_top = GOODS_PADDING + (GOODS_ITEM_HEIGHT + GOODS_MARGIN) * row
          item_canvas = AntGui::Canvas.new
          AntGui::Canvas.set_canvas_props item_canvas, item_left, item_top, GOODS_ITEM_WIDTH, GOODS_ITEM_HEIGHT
          goods_panel.add item_canvas

          item_image = ShoppingItemControl.new item[:image], item[:anim], item[:price]
          item_image.background_color = COLOR_GOODS_ITEM_BACK
          AntGui::Canvas.set_canvas_props item_image, 0, 0, GOODS_ITEM_WIDTH, GOODS_IMAGE_HEIGHT

          item_image.on_mouse_left_button_down do
            wear item[:equipment_type].to_sym, item[:key]
          end

          if item[:existing]
            buy_button = AntGui::TextBlock.new(@font, '购买', :center, :center)
            buy_button.foreground_color = COLOR_BTN_BUY_EXIST_FORE
            buy_button.background_color = COLOR_BTN_BUY_EXIST_BACK
          else
            buy_button = create_button '购买'
            buy_button.foreground_color = COLOR_BTN_BUY_NEW_FORE
            buy_button.background_color = COLOR_BTN_BUY_NEW_BACK
            buy_button.on_mouse_left_button_down do
              buy item[:key]
            end
          end

          AntGui::Canvas.set_canvas_props buy_button, 0, GOODS_ITEM_HEIGHT - GOODS_PAY_BUTTON_HEIGHT,
                                          GOODS_ITEM_WIDTH, GOODS_PAY_BUTTON_HEIGHT

          item_canvas.add item_image
          item_canvas.add buy_button

          index += 1
        end
      end
    end

    goods_panel
  end

  def wear(equipment_type, key)
    if Equipment::role_equipment_types.include? equipment_type
      equipment_vm = EquipmentViewModelFactory.create_equipment_from_key equipment_type, key.to_sym
      @role_preview.equip_vm = equipment_vm
    end
  end

  def buy(key)
    @shopping_view_model.buy key
    active
  end

  def create_page_panel(left, top, width, height)
    button_width = 120
    button_height = height

    page_panel = AntGui::Canvas.new
    AntGui::Canvas.set_canvas_props page_panel, left, top, width, height

    prev_page_button = create_button '上一页'
    next_page_button = create_button '下一页'

    prev_page_button.on_mouse_left_button_down do
      if @page_no > 1
        @page_no -= 1
        update_ui
      end
    end

    next_page_button.on_mouse_left_button_down do
      if @page_no < @total_page_count
        @page_no += 1
        update_ui
      end
    end

    page_no_text_block = AntGui::TextBlock.new(@font, "#{@page_no}/#{@total_page_count}", :center, :center)
    page_no_text_block.foreground_color = COLOR_PAGE_NO

    AntGui::Canvas.set_canvas_props page_no_text_block, 0, 0, width, height
    AntGui::Canvas.set_canvas_props prev_page_button, 0, 0, button_width, button_height
    AntGui::Canvas.set_canvas_props next_page_button, width - button_width, 0, button_width, button_height


    page_panel.add page_no_text_block
    page_panel.add prev_page_button
    page_panel.add next_page_button

    page_panel
  end

  def create_right_panel(left, top, width, height)
    right_panel = AntGui::Canvas.new
    AntGui::Canvas.set_canvas_props right_panel, left, top, width, height

    button_height = 34

    recharge_button = create_button '【土豪充值入口】'
    recharge_button.on_mouse_left_button_down do
      recharge_url = NetworkConfig::RECHARGE_URL
      system "start explorer #{recharge_url}"
    end

    exchange_button = create_button '所有垃圾兑换成货币'
    exchange_button.on_mouse_left_button_down do
      convert_to_money
    end

    gift_button = create_button '30级免费申领第一辆车'
    gift_button.on_mouse_left_button_down do
      apply_gift_vehicle
    end

    quit_button = create_button '返回主界面'
    quit_button.on_mouse_left_button_down do
      @exit_call_back.call
    end

    margin = 25
    y = height - button_height
    AntGui::Canvas.set_canvas_props quit_button, 0, y, width, button_height
    y -= button_height + margin
    AntGui::Canvas.set_canvas_props gift_button, 0, y, width, button_height
    y -= button_height + margin
    AntGui::Canvas.set_canvas_props exchange_button, 0, y, width, button_height
    y -= button_height + margin
    AntGui::Canvas.set_canvas_props recharge_button, 0, y, width, button_height

    right_panel.add quit_button
    right_panel.add gift_button
    right_panel.add exchange_button
    right_panel.add recharge_button
    right_panel
  end

  def apply_gift_vehicle
    @shopping_view_model.apply_gift_vehicle
    active
  end

  def convert_to_money
    @shopping_view_model.convert_to_money
    active
  end

  def create_button(text, color_normal_back=COLOR_BUTTON_NORMAL_BACK, color_hover_back=COLOR_BUTTON_HOVER_BACK)
    button = AntGui::TextBlock.new(@font, text, :center, :center)
    button.foreground_color = COLOR_BUTTON_FORE
    button.background_color = color_normal_back
    button.on_mouse_enter do
      button.background_color = color_hover_back
    end
    button.on_mouse_leave do
      button.background_color = color_normal_back
    end
    button
  end

  def init_money
    @image_gold = @window_resource_service.get_gold_image
    @image_silver = @window_resource_service.get_silver_image
    # @image_copper = MediaUtil::get_img 'money/copper.bmp'
    @font_money = @window_resource_service.get_font_25
    @gold = @silver = 0
  end

  def active
    update_money
    update_ui
  end

  def update_money
    amount = @account_service.get_amount(@user_service.user_id)
    @gold = amount / 100
    @silver = amount % 100
  end

  def draw
    GraphicsUtil.draw_linear_rect(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::MAP_HEIGHT,
                                  ZOrder::Background, COLOR_MAIN_BACK_1, COLOR_MAIN_BACK_2)

    @role_preview.draw nil

    draw_bottom_bar

    @dialog.draw
  end

  def draw_bottom_bar
    left, top, width, height = 0, GameConfig::MAP_HEIGHT, GameConfig::MAP_WIDTH, GameConfig::WHOLE_HEIGHT - GameConfig::MAP_HEIGHT
    GraphicsUtil.draw_linear_rect(left, top, width, height, ZOrder::Background,
                                  COLOR_BOTTOM_BAR_BACK_1, COLOR_BOTTOM_BAR_BACK_2)

    margin = 10
    money_image_width = 60
    money_value_width = 50
    x = 10
    y = top + height / 2
    z = ZOrder::Background

    @image_gold.draw_rot(x, y, z, 0, 0, 0.5, 1, 1)
    x += money_image_width + margin
    @font_money.draw_rel(@gold, x, y, z, 0, 0.5, 1.0, 1.0, COLOR_MONEY_FORE)
    x += money_value_width + margin

    @image_silver.draw_rot(x, y, z, 0, 0, 0.5, 1, 1)
    x += money_image_width + margin
    @font_money.draw_rel(@silver, x, y, z, 0, 0.5, 1.0, 1.0, COLOR_MONEY_FORE)
    # x += money_value_width + margin
    # @image_copper.draw_rot(x, y, z, 0, 0, 0.5, 1, 1)
    # x += money_image_width + margin
    # @font_money.draw_rel('99', x, y, z, 0, 0.5, 1.0, 1.0, 0xFF_905810)
    # x += money_value_width + margin
  end

  def update
    @dialog.mouse_move(@window.mouse_x, @window.mouse_y)
  end

  def button_down(id)
    if id == Gosu::MsLeft
      @dialog.mouse_left_button_down(@window.mouse_x, @window.mouse_y)
    end
  end
end