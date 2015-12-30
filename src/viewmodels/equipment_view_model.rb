class EquipmentViewModel
  attr_reader :equipment, :key

  def initialize(equipment)
    @equipment = equipment
    @key = equipment.key
    init_anims
  end

  def miss
    @equipment.miss
  end

  def speed_up
    @equipment.speed_up
  end

  def type
    @equipment.type
  end

  def draw(role_x, role_y, direction)
    direction_text = Direction::to_direction_text direction
    anim = self.instance_variable_get("@anim_#{direction_text}")
    return if anim.nil?
    x, y = role_x, role_y
    offset_x, offset_y = @equipment.location_offset[direction_text.to_sym]
    anim.draw(x + offset_x, y + offset_y, ZOrder::Player)
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