class RoleViewModel
  attr_reader :role

  def initialize(role)
    autowired(MapService)
    @player = @role = role
    @beep = MediaUtil::get_sample('eat.wav')
    @font = Gosu::Font.new(15)
    init_animations
    @eating_food_vm = nil
  end

  def update

  end

  def draw
    draw_role_anim
    @eating_food_vm.draw unless @eating_food_vm.nil?
    draw_level_and_name
  end

  private

  def draw_text_with_border(text, x, y, z, scale_x, scale_y, color, border_color)
    @font.draw(text, x, y-1, z, scale_x, scale_y, border_color)
    @font.draw(text, x, y+1, z, scale_x, scale_y, border_color)
    @font.draw(text, x-1, y, z, scale_x, scale_y, border_color)
    @font.draw(text, x+1, y, z, scale_x, scale_y, border_color)
    @font.draw(text, x, y, z, scale_x, scale_y, color, :additive)
  end

  def lv_image
    LevelUtil.image(@role.lv)
  end

  def change_anim
    state = @role.state.to_s

    direction = ''
    if Direction::is_direct_to_left(@role.direction)
      direction = 'left'
    elsif Direction::is_direct_to_right(@role.direction)
      direction = 'right'
    elsif Direction::is_direct_to_up(@role.direction)
      direction = 'up'
    elsif Direction::is_direct_to_down(@role.direction)
      direction = 'down'
    end

    @current_anim = self.instance_variable_get("@anim_#{state}_#{direction}")
  end

  def get_anim(key)
    AnimationManager.get_anim key
  end

  def init_animations
    role = @role.role_type.to_s
    %w(stand walk run eat hold_food).each do |state|
      %w(left right up down).each do |direction|
        self.instance_variable_set("@anim_#{state}_#{direction}",
                                   get_anim("#{role}_#{state}_#{direction}".to_sym))
      end
    end

    @current_anim = @anim_stand_down
  end

  def draw_role_anim
    @current_anim.draw(@role.x, @role.y - 26, ZOrder::Player)
  end

  def draw_level_and_name
    name_width = @font.text_width(@role.name)
    lv_img_width = 15
    whole_width = lv_img_width + 2 + name_width
    level_left = @role.x - whole_width / 2
    level_height = @role.y + 14
    draw_text_with_border(@role.name, level_left + lv_img_width + 2, level_height, ZOrder::Player,
                          1, 1, 0xFF_CFC2BC, 0xFF_251B00)
    lv_image.draw(level_left, level_height, ZOrder::Player)
  end
end