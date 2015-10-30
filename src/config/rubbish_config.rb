# coding: UTF-8

lambda {
  id = 0
  add = lambda do |name|
    image_path = "rubbish/#{id}.bmp"
    rubbish_type_info = RubbishTypeInfo.new id, name, image_path
    RubbishTypeInfo.put id, rubbish_type_info
    RubbishTypeInfo.cache_image id, MediaUtil::get_img(rubbish_type_info.image_path)
    id += 1
  end

  %w(破饭碗 空易拉罐 有洞的平锅 农药瓶 方便面袋
    苹果核 酒瓶 一只靴子 自行车轮胎 擤鼻涕纸
    破呢帽 破平底锅).each &add
}.call

