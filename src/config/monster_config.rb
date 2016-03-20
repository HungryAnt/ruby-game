# coding: UTF-8

lambda {
  def to_monster_sound(sound)
    "/monster/#{sound}.wav"
  end

  add = lambda do |id, name, height, sound|
    monster_type_id = "monster_#{id}"
    sound_move = to_monster_sound(sound + '1')
    sound_attack = to_monster_sound(sound + '2')
    sound_capitulate = to_monster_sound(sound + '3')
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height,
                                            sound_move, sound_attack, sound_capitulate
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


  def to_wild_monster_sound(sound)
    "/wild_monster/#{sound}.wav"
  end

  add_wild_monster = lambda do |id, name, height, sound|
    monster_type_id = "wild_monster_#{id}"
    sound_move = to_wild_monster_sound(sound + '1')
    sound_attack = to_wild_monster_sound(sound + '5')
    sound_capitulate = to_wild_monster_sound(sound + '3')
    monster_type_info = MonsterTypeInfo.new monster_type_id, name, height, sound_move, sound_attack, sound_capitulate
    MonsterTypeInfo.put monster_type_id, monster_type_info
  end

  add_wild_monster.call '0001', '幼年期精灵', 60, 'MiniMongk'
  add_wild_monster.call '0002', '成年期精灵', 110, 'Mongk'
  add_wild_monster.call '0003', '神秘精灵', 80, 'RedFling'
  add_wild_monster.call '0004', '地牢守卫', 180, 'StoneDoorman'
  add_wild_monster.call '0005', '肥龙', 220, 'DarkDragon'
  add_wild_monster.call '0006', '大嘴怪', 180, 'PumpKin'
  add_wild_monster.call '0007', '死神', 220, 'Cranium'
  add_wild_monster.call '0008', '小调皮', 240, 'GreatDevil' # 大恶魔
  add_wild_monster.call '0009', '稻草人', 120, 'Scarecrow'
  add_wild_monster.call '0010', '西瓜虫', 50, 'WatermelonBug'
  add_wild_monster.call '0011', '大型螳螂', 130, 'Mantis'
  add_wild_monster.call '0012', '骷髅头', 120, 'BlindnessBone'
  add_wild_monster.call '0013', '邪恶的发明家酒桶', 170, 'OrcLog'
  add_wild_monster.call '0014', '马戏团小丑', 200, 'CircusGhost'
  add_wild_monster.call '0015', '法老王', 250, 'PharaohGreatDevil'
}.call
