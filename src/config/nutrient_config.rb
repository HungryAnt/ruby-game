# coding: UTF-8

lambda {
  add_nutrient_type = proc do |id, name|
    image_path = "nutrient/#{id}.bmp"
    nutrient_type_info = NutrientTypeInfo.new id, name, image_path
    NutrientTypeInfo.put id, nutrient_type_info
    NutrientTypeInfo.cache_image id, MediaUtil::get_img(nutrient_type_info.image_path)
  end

  add_nutrient_type.call 0, '露水'
  add_nutrient_type.call 1, '栗子'
  add_nutrient_type.call 2, '草莓'
}.call

