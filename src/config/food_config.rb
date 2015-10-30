# coding: UTF-8

lambda {
  id = 0

  add = lambda do |names|
    names.each do |name|
      image_path = "food/#{id}.bmp"
      food_type_info = FoodTypeInfo.new id, name, image_path, 50
      MediaUtil::get_img(food_type_info.image_path) # 主线程初始加载图片，bugFix:子线程加载图片无法显示
      FoodTypeInfo.put id, food_type_info
      id += 1
    end
  end

  add.call %w(三明治 比萨 一块柠檬 栗子面包 巴西柠檬)
  add.call %w(小蛋糕 菠菜 野菜包饭 传统热狗 白萝卜)
  add.call %w(雪糕 煮玉米 奶酪饼干 奶酪比萨 可乐)
  add.call %w(白菜 绿苹果 咖啡 甜心包饭 胡萝卜)
  add.call %w(梨子 奶油蛋糕 草莓蛋糕 华夫饼干 草莓饼干)
  add.call %w(虾条 西瓜 冰淇淋 双棒雪糕 樱桃)
  add.call %w(野菜面包 青柠檬 巧克力派 紫菜饭 猕猴桃)
  add.call %w(热狗 羊肉串 炸鸡腿)
}.call

