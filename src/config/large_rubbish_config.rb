# coding: UTF-8

def add_large_rubbish_type(id, name)
  images = []
  0.upto(3) do |i|
    path = "large_rubbish/#{id}/#{'%04d' % id}_#{i}.bmp"
    images << MediaUtil::get_img(path)
  end
  large_rubbish_type_info = LargeRubbishTypeInfo.new id, name, images
  LargeRubbishTypeInfo.put id, large_rubbish_type_info
end

add_large_rubbish_type 0, '水壶'
add_large_rubbish_type 1, '吸尘器'
add_large_rubbish_type 2, '喷壶'
add_large_rubbish_type 3, '游戏机'
add_large_rubbish_type 4, '音箱'
add_large_rubbish_type 5, '电饭锅'
add_large_rubbish_type 6, '石磨'
add_large_rubbish_type 7, '轮胎'
add_large_rubbish_type 8, '电脑主机'
add_large_rubbish_type 9, '冰柜'
add_large_rubbish_type 10, '沙发'
add_large_rubbish_type 11, '坐便器'
add_large_rubbish_type 12, '熨斗'
add_large_rubbish_type 13, 'VCD播放机'
add_large_rubbish_type 14, '小型台灯'
add_large_rubbish_type 15, '电话机'
add_large_rubbish_type 16, '录音机'
add_large_rubbish_type 17, '摄影机'
add_large_rubbish_type 18, '餐椅'
add_large_rubbish_type 19, '铁锅'
add_large_rubbish_type 20, '显示器'
add_large_rubbish_type 21, '洗衣机'
add_large_rubbish_type 22, '小轮摩托车'
add_large_rubbish_type 23, '汽车'
add_large_rubbish_type 24, '柜子'
add_large_rubbish_type 25, '破自行车'
add_large_rubbish_type 26, '拖拉机'
add_large_rubbish_type 27, '电风扇'
add_large_rubbish_type 28, '铁柜'