# coding: UTF-8

def add_rubbish_type(id, name)
  image_path = "rubbish/#{id}.bmp"
  rubbish_type_info = RubbishTypeInfo.new id, name, image_path
  RubbishTypeInfo.put id, rubbish_type_info
  RubbishTypeInfo.cache_image id, MediaUtil::get_img(rubbish_type_info.image_path)
end

add_rubbish_type 0, '破饭碗'
add_rubbish_type 1, '空易拉罐'
add_rubbish_type 2, '有洞的平锅'
add_rubbish_type 3, '农药瓶'
add_rubbish_type 4, '方便面袋'
add_rubbish_type 5, '苹果核'
add_rubbish_type 6, '酒瓶'
add_rubbish_type 7, '一只靴子'
add_rubbish_type 8, '自行车轮胎'
add_rubbish_type 9, '擤鼻涕纸'
add_rubbish_type 10, '破呢帽'
add_rubbish_type 11, '破平底锅'

