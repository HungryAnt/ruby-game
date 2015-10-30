# coding: UTF-8

lambda {
  add = lambda do |id, name|
    images = []
    0.upto(3) do |i|
      path = "large_rubbish/#{id}/#{'%04d' % id}_#{i}.bmp"
      images << MediaUtil::get_img(path)
    end
    large_rubbish_type_info = LargeRubbishTypeInfo.new id, name, images
    LargeRubbishTypeInfo.put id, large_rubbish_type_info
  end

  add.call 0, '水壶'
  add.call 1, '吸尘器'
  add.call 2, '喷壶'
  add.call 3, '游戏机'
  add.call 4, '音箱'
  add.call 5, '电饭锅'
  add.call 6, '石磨'
  add.call 7, '轮胎'
  add.call 8, '电脑主机'
  add.call 9, '冰柜'
  add.call 10, '沙发'
  add.call 11, '坐便器'
  add.call 12, '熨斗'
  add.call 13, 'VCD播放机'
  add.call 14, '小型台灯'
  add.call 15, '电话机'
  add.call 16, '录音机'
  add.call 17, '摄影机'
  add.call 18, '餐椅'
  add.call 19, '铁锅'
  add.call 20, '显示器'
  add.call 21, '洗衣机'
  add.call 22, '小轮摩托车'
  add.call 23, '汽车'
  add.call 24, '柜子'
  add.call 25, '破自行车'
  add.call 26, '拖拉机'
  add.call 27, '电风扇'
  add.call 28, '铁柜'
}.call
