class VehicleViewModel
  attr_reader :key, :vehicle, :vehicle_body_height, :speed_up, :is_behind_role, :is_cloak, :miss

  def initialize(key)
    @key = key
    init_anims key
    props = EquipmentDefinition.get_props key
    @vehicle_body_height = props[:body_height]
    @speed_up = props[:speed_up]
    @location_offset = props[:offset]
    @vehicle = Vehicle.new(key, @speed_up)
    @is_behind_role = props[:is_behind_role]
    @is_cloak = props[:is_cloak]
    @miss = props[:miss]
  end

  def type
    Equipment::Type::VEHICLE
  end

  def draw(role_x, role_y, direction, scale=1)
    @scale = scale
    direction_text = Direction::to_direction_text direction
    anim = self.instance_variable_get("@anim_#{direction_text}")
    x, y = role_x, role_y - 30 * @scale
    offset_x, offset_y = @location_offset[direction_text.to_sym]
    anim.draw(x + offset_x * @scale, y + offset_y * @scale, ZOrder::Player, scale_x:@scale, scale_y:@scale)
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