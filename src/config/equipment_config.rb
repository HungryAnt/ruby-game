def create_equipment_anims(equipment, id, options = {})
  anim_interval = 150
  pattern = options.include?(:pattern) ? options[:pattern] : "#{equipment}/#{id}/#{id}_${num}.bmp"

  if options.include?(:same_nums_pair)
    hor_nums = up_nums = down_nums = to_anim_nums(*options[:same_nums_pair])
  else
    hor_nums = options.include?(:hor_nums_pair) ? to_anim_nums(*options[:hor_nums_pair]) : nil
    up_nums = options.include?(:up_nums_pair) ? to_anim_nums(*options[:up_nums_pair]) : nil
    down_nums = options.include?(:down_nums_pair) ? to_anim_nums(*options[:down_nums_pair]) : nil
  end

  AnimationManager.new_centered_anims '' do
    map = {}
    map["#{equipment}_#{id}_left".to_sym] = [pattern, hor_nums, anim_interval] unless hor_nums.nil?
    map["#{equipment}_#{id}_right".to_sym] = [pattern, hor_nums, anim_interval, -1] unless hor_nums.nil?
    map["#{equipment}_#{id}_up".to_sym] = [pattern, up_nums, anim_interval] unless up_nums.nil?
    map["#{equipment}_#{id}_down".to_sym] = [pattern, down_nums, anim_interval] unless down_nums.nil?
    map
  end
end

def set_equipment_properties(equipment, id, options={})
  key = "#{equipment}_#{id}".to_sym

  offset = {}

  [:left, :up, :down].each do |sym|
    if options.include? sym
      offset[sym] = options[sym]
    end
  end

  if options.include? :left
    offset[:right] = [-offset[:left][0], offset[:left][1]]
  end

  EquipmentDefinition.set_props key, offset: offset

  unless options.include? :ignore_image
    EquipmentDefinition.set_item_image key, "#{equipment}/#{id}/#{id}_0.bmp"
  end
end
