require_relative 'large_rubbish_type_info'
require_relative 'location'

# ´óÐÍÀ¬»ø
class LargeRubbish
  attr_reader :id, :name, :max_hp, :hp, :images

  include Location

  def initialize(id, x, y, large_rubbish_type_id, max_hp, hp)
    @id = id
    @large_rubbish_type_id = large_rubbish_type_id
    large_rubbish_type_info = LargeRubbishTypeInfo.get large_rubbish_type_id
    @images = large_rubbish_type_info.images
    @name = large_rubbish_type_info.name
    init_location x, y
    @max_hp, @hp = max_hp, hp
  end

  def update_hp(hp)
    @hp = hp
  end
end