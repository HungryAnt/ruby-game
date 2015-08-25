class EquipmentViewModel
  attr_reader :vehicle_body_height

  def initialize(key, vehicle_body_height)
    init_anims key
    @vehicle_body_height = vehicle_body_height
    @location_offset = get_location_offset(key)
  end

  def draw(role_x, role_y, direction)
    direction_text = Direction::to_direction_text direction
    anim = self.instance_variable_get("@anim_#{direction_text}")
    x, y = role_x, role_y - 30
    offset_x, offset_y = @location_offset[direction_text.to_sym]
    anim.draw(x + offset_x, y + offset_y, ZOrder::Player)
  end

  private

  def init_anims(key)
    %w(left right up down).each do |direction|
      self.instance_variable_set("@anim_#{direction}",
                                 get_anim("#{key}_#{direction}".to_sym))
    end
  end

  def get_anim(key)
    AnimationManager.get_anim key
  end

  def get_location_offset(key)
    EquipmentDefinition.get_location_offset key
  end
end