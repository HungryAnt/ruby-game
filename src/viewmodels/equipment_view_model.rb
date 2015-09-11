class EquipmentViewModel
  attr_reader :vehicle_body_height, :speed_up

  def initialize(key)
    init_anims key
    props = EquipmentDefinition.get_props key
    @vehicle_body_height = props[:body_height]
    @speed_up = props[:speed_up]
    @location_offset = props[:offset]

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
end