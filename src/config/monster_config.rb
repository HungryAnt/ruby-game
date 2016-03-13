# coding: UTF-8

lambda {
  def to_monster_sound(sound)
    "/monster/#{sound}.wav"
  end

  add = lambda do |id, name, height, sound|
    monster_type_id = "monster_#{id}"
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height,
                                            to_monster_sound(sound + '1'),
                                            to_monster_sound(sound + '2'),
                                            to_monster_sound(sound + '3')
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add.call '0001', '鳄鱼', 120, 'Crocodile'
  add.call '0002', '野猫', 185, 'Cat'
  add.call '0004', '变异鼠', 138, 'BandMouse'
  add.call '0005', '眼镜蛇', 135, 'Cobra'
  add.call '0006', '秃鹫', 125, 'Eagle'
  add.call '0007', '鼹鼠', 135, 'Mole'
  add.call '0008', '犀牛', 155, 'Rhinoceros'
  add.call '20000', '雪人', 167, 'SnowMan'

  add_wild_monster = lambda do |id, name, height|
    monster_type_id = "wild_monster_#{id}"
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height, nil, nil, nil
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add_wild_monster.call '0001', '幼年期精灵', 50
  add_wild_monster.call '0002', '成年期精灵', 50
  add_wild_monster.call '0003', '神秘精灵', 50
  add_wild_monster.call '0004', '石碑守卫', 50
  add_wild_monster.call '0005', '肥龙', 50
  add_wild_monster.call '0006', '大嘴怪', 50
  add_wild_monster.call '0007', '死神', 50
  add_wild_monster.call '0008', '大恶魔', 50
  add_wild_monster.call '0009', '稻草人', 50
  add_wild_monster.call '0010', '菜青虫', 50
  add_wild_monster.call '0011', '大型螳螂', 50
  add_wild_monster.call '0012', '骷髅头', 50
  add_wild_monster.call '0013', '邪恶的发明家酒桶', 50
  add_wild_monster.call '0014', '马戏团小丑', 50
  add_wild_monster.call '0015', '金字塔守卫', 50
}.call
