# coding: UTF-8

lambda {
  add = lambda do |id, name, height|
    monster_type_id = "monster_#{id}"
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add.call '0001', '鳄鱼', 120
  add.call '0002', '野猫', 185
  add.call '0004', '变异鼠', 138
  add.call '0005', '眼镜蛇', 135
  add.call '0006', '秃鹫', 125
  add.call '0007', '鼹鼠', 135
  add.call '0008', '犀牛', 155
  add.call '20000', '雪人', 167
}.call
