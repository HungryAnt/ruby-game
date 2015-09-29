require_relative 'rubbish_type_info'

class Rubbish < Item
  attr_reader :rubbish_type_id

  def initialize(id, x, y, rubbish_type_id)
    init_item(id, Item::ItemType::RUBBISH, x, y)
    @rubbish_type_id = rubbish_type_id
    @rubbish_type_info = RubbishTypeInfo.get(rubbish_type_id)
  end

  def image_path
    @rubbish_type_info.image_path
  end

  def to_rubbish_map
    {
        rubbish_type_id: @rubbish_type_info.id
    }
  end
end