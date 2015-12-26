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
}.call
