class ShoppingView < ViewBase
  GOODS_ITEM_WIDTH = 110
  GOODS_ITEM_HEIGHT = 95 + 5 + 25
  GOODS_IMAGE_HEIGHT = 95
  GOODS_PAY_BUTTON_HEIGHT = 25

  GOODS_PADDING = 10
  GOODS_MARGIN = 10
  GOODS_ROW_COUNT = 3
  GOODS_COL_COUNT = 3

  def initialize(window)
    super
    init_ui
  end

  def on_exit(&exit_call_back)
    @exit_call_back = exit_call_back
  end

  def active

  end

  def init_ui
    # AntGui::Facade.create_image_button()

    @dialog = AntGui::Dialog.new(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT)
    main_canvas = AntGui::Canvas.new
    @dialog.content = main_canvas

    goods_canvas = AntGui::Canvas.new
    main_canvas.add goods_canvas

    goods_canvas_width = GOODS_ITEM_WIDTH * GOODS_COL_COUNT + GOODS_MARGIN * (GOODS_COL_COUNT - 1) + GOODS_PADDING * 2
    goods_canvas_height = GOODS_ITEM_HEIGHT * GOODS_ROW_COUNT + GOODS_MARGIN * (GOODS_ROW_COUNT - 1) + GOODS_PADDING * 2

    AntGui::Canvas.set_canvas_props goods_canvas, 60, 80, goods_canvas_width, goods_canvas_height
    goods_canvas.background_color = 0xFF_382915

    0.upto(GOODS_ROW_COUNT - 1).each do |row|
      0.upto(GOODS_COL_COUNT - 1).each do |col|
        item_left = GOODS_PADDING + (GOODS_ITEM_WIDTH + GOODS_MARGIN) * col
        item_top = GOODS_PADDING + (GOODS_ITEM_HEIGHT + GOODS_MARGIN) * row
        item_canvas = AntGui::Canvas.new
        AntGui::Canvas.set_canvas_props item_canvas, item_left, item_top, GOODS_ITEM_WIDTH, GOODS_ITEM_HEIGHT
        goods_canvas.add item_canvas

        item_image = AntGui::Control.new
        item_image.background_color = 0xFF_EADAC5
        AntGui::Canvas.set_canvas_props item_image, 0, 0, GOODS_ITEM_WIDTH, GOODS_IMAGE_HEIGHT

        item_payment_btn = AntGui::Control.new
        item_payment_btn.background_color = 0xFF_EADAC5
        AntGui::Canvas.set_canvas_props item_payment_btn, 0, GOODS_ITEM_HEIGHT - GOODS_PAY_BUTTON_HEIGHT,
                                        GOODS_ITEM_WIDTH, GOODS_PAY_BUTTON_HEIGHT

        item_canvas.add item_image
        item_canvas.add item_payment_btn
      end
    end

    @dialog.update_arrange
  end

  def draw
    GraphicsUtil.draw_linear_rect(0, 0, GameConfig::WHOLE_WIDTH, GameConfig::MAP_HEIGHT,
                                  ZOrder::Background, 0xFF_906838, 0xFF_C0A068)

    GraphicsUtil.draw_linear_rect(0, GameConfig::MAP_HEIGHT, GameConfig::WHOLE_WIDTH, GameConfig::WHOLE_HEIGHT,
                                  ZOrder::Background, 0xFF_FEFEFE, 0xFF_DBDBDB)

    @dialog.draw
  end
end