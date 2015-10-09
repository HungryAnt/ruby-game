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