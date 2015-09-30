class ShoppingItemControl < AntGui::Control
  def initialize(image, price)
    super()
    autowired(WindowResourceService)
    @image = image
    @gold = price / 100
    @silver = price % 100
    @image_gold = @window_resource_service.get_gold_image
    @image_silver = @window_resource_service.get_silver_image
    @font_goods_money = @window_resource_service.get_goods_money_font
  end

  def do_draw(z)
    super
    control_top, control_height = @actual_top + 15, @actual_height - 15
    if @image.width > @actual_width || @image.height > control_height
      scale_x = @actual_width * 1.0 / @image.width
      scale_y = control_height * 1.0 / @image.height
      scale_x = scale_y = [scale_x, scale_y].min
      left = @actual_left + (@actual_width - @image.width * scale_x) / 2
      top = control_top + (control_height - @image.height * scale_y) / 2
    else
      left = @actual_left + (@actual_width - @image.width)/2
      top = control_top + (control_height - @image.height)/2
      scale_x = scale_y = 1
    end
    @image.draw(left, top, z, scale_x, scale_y, 0xff_ffffff, mode=:default)
    draw_price z
  end

  def draw_price(z)
    margin = 9
    money_image_width = 20
    money_image_height = 12
    money_value_width = 15
    x = @actual_left + 5
    y = @actual_top + money_image_height / 2 + 3

    scale_x = money_image_width * 1.0 / @image_gold.width
    scale_y = money_image_height * 1.0 / @image_gold.height

    if @gold > 0
      @image_gold.draw_rot(x, y, z, 0, 0, 0.5, scale_x, scale_y)
      x += money_image_width + margin
      @font_goods_money.draw_rel(@gold, x, y, z, 0, 0.5, 1.0, 1.0, 0xFF_FFFFFF)
      x += money_value_width + margin
    end

    if @silver > 0
      @image_silver.draw_rot(x, y, z, 0, 0, 0.5, scale_x, scale_y)
      x += money_image_width + margin
      @font_goods_money.draw_rel(@silver, x, y, z, 0, 0.5, 1.0, 1.0, 0xFF_FFFFFF)
    end
  end
end