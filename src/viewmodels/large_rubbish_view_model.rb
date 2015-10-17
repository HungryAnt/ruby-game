class LargeRubbishViewModel
  SMASH_DISTANCE = 90
  INFO_BOARD_WIDTH = 106
  INFO_BOARD_HEIGHT = 37
  HP_BAR_WIDTH = 64
  HP_BAR_HEIGHT = 5
  HP_BAR_BORDER = 3

  attr_reader :large_rubbish

  def initialize(large_rubbish)
    autowired(WindowResourceService)
    @large_rubbish = large_rubbish
  end

  def id
    @large_rubbish.id
  end

  def x
    @large_rubbish.x
  end

  def y
    @large_rubbish.y
  end

  def name
    @large_rubbish.name
  end

  def update_large_rubbish(large_rubbish)
    @large_rubbish = large_rubbish
  end

  def draw
    image_index = @large_rubbish.images.size - 1 -
        @large_rubbish.hp.to_i * @large_rubbish.images.size / (@large_rubbish.max_hp + 1)
    image = @large_rubbish.images[image_index]
    if image_index == 3
      puts 'OK!!!! image_index == 3'
    end
    image.draw_rot(@large_rubbish.x, @large_rubbish.y, ZOrder::Player, 0,
                   0.5, 0.67)
    draw_info_board
    draw_name
    draw_hp
  end

  def draw_info_board
    x = (GameConfig::MAP_WIDTH - INFO_BOARD_WIDTH) / 2
    y = 25
    GraphicsUtil::draw_rect_border x-1, y-1, INFO_BOARD_WIDTH + 3, INFO_BOARD_HEIGHT + 3, 0xEE_210B00, ZOrder::UI
    GraphicsUtil::draw_rect_border x, y, INFO_BOARD_WIDTH + 1, INFO_BOARD_HEIGHT + 1, 0xEE_D5AA88, ZOrder::UI
    Gosu::draw_rect x, y, INFO_BOARD_WIDTH, INFO_BOARD_HEIGHT, 0xAB_220B00, ZOrder::UI
  end

  def draw_name
    font = @window_resource_service.get_font_16
    text_width = font.text_width(name)
    x = (GameConfig::MAP_WIDTH - text_width) / 2
    y = 28
    GraphicsUtil.draw_text_with_border(name, font, x, y,
                                       ZOrder::UI, 1, 1, 0xFF_F5CAA8, 0xEE_210B00)
  end

  def draw_hp
    rate = 1.0 * @large_rubbish.hp / @large_rubbish.max_hp
    current_hp_width = HP_BAR_WIDTH * rate
    x = (GameConfig::MAP_WIDTH - HP_BAR_WIDTH) / 2
    y = 49
    GraphicsUtil::draw_rect_border x-1, y-1, HP_BAR_WIDTH + 3, HP_BAR_HEIGHT + 3, 0xFF_F5CAA8, ZOrder::UI
    GraphicsUtil::draw_rect_border x, y, HP_BAR_WIDTH + 1, HP_BAR_HEIGHT + 1, 0xEE_210B00, ZOrder::UI

    c0 = Gosu::Color.new(0xFF, 0xEA, 0x53, 0x20)
    # c2 = Gosu::Color.new(0xFF, 0xEA, 0xF6, 0x20)
    c1 = Gosu::Color.new(0xFF, 0xEA, 0x53 + ((0xF6 - 0x53) * rate).to_i, 0x20)
    GraphicsUtil::draw_linear_rect(x, y, current_hp_width, HP_BAR_HEIGHT,
                                   ZOrder::UI, c0, c1, direction:'hor')
  end

  def mouse_touch?(mouse_x, mouse_y)
    distance(mouse_x, mouse_y) < 60
  end

  def can_smash?(role)
    distance(role.x, role.y) < SMASH_DISTANCE
  end

  def get_destination(role)
    angle = Gosu::angle(@large_rubbish.x, @large_rubbish.y, role.x, role.y)
    dest_x = @large_rubbish.x + Gosu::offset_x(angle, SMASH_DISTANCE)
    dest_y = @large_rubbish.y + Gosu::offset_y(angle, SMASH_DISTANCE)
    [dest_x, dest_y]
  end

  # def smash
  #   hp_dec = 3
  #   hp_dec = @large_rubbish.hp if hp_dec > @large_rubbish.hp
  #   @large_rubbish.update_hp @large_rubbish.hp - hp_dec
  # end

  private
  def distance(x, y)
    Gosu::distance(@large_rubbish.x, @large_rubbish.y, x, y)
  end
end