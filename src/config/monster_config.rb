# coding: UTF-8

lambda {
  add = lambda do |id, name, height|
    monster_type_id = "monster_#{id}"
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add.call '0002', '野猫', 170
  add.call '0004', '变异鼠', 140
}.call
