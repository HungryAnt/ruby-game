# coding: UTF-8

lambda {
  add = lambda do |id, name, height|
    monster_type_id = "monster_#{id}"
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add.call '0001', '鳄鱼', 100
  add.call '0002', '野猫', 170
  add.call '0004', '变异鼠', 140
  add.call '0005', '眼镜蛇', 100
  add.call '0006', '秃鹫', 100
  add.call '0007', '鼹鼠', 100
  add.call '0008', '犀牛', 100
  add.call '20000', '雪人', 100
}.call
