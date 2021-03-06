class EquipmentViewModel
  attr_reader :equipment, :key

  def initialize(equipment)
    @equipment = equipment
    @key = equipment.key
    init_anims
  end

  def type
    @equipment.type
  end

  def miss
    @equipment.miss
  end

  def speed_up
    @equipment.speed_up
  end

  def height
    @equipment.height
  end

  def is_cloak
    @equipment.is_cloak
  end

  def draw(role_x, role_y, direction, scale=1)
    @scale = scale
    direction_text = Direction::to_direction_text direction
    anim = self.instance_variable_get("@anim_#{direction_text}")
    return if anim.nil?
    x, y = role_x, role_y
    # 历史原因，vehicle y坐标需要做一定偏移
    y -= 30 * @scale if type == Equipment::Type::VEHICLE

    offset_x, offset_y = @equipment.location_offset[direction_text.to_sym]
    anim.draw(x + offset_x * @scale, y + offset_y * @scale, ZOrder::Player, scale_x:@scale, scale_y:@scale)
  end

  private

  def init_anims
    %w(left right up down).each do |direction|
      self.instance_variable_set("@anim_#{direction}",
                                 get_anim("#{@key}_#{direction}".to_sym))
    end
  end

  def get_anim(key)
    AnimationManager.get_anim key
  end
end