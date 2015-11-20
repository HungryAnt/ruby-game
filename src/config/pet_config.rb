# coding: UTF-8

lambda {
  add = lambda do |flag, num, name|
    pet_id = "pet_#{flag}#{num}".to_sym
    pet_type_info = PetTypeInfo.new pet_id, name
    PetTypeInfo.put pet_id, pet_type_info
    EquipmentDefinition.set_item_image pet_id, "pet/#{flag}#{num}/#{num}_0.bmp"
  end

  add.call 'c', 1, '佳茹贝贝'
  add.call 'c', 2, '绿蚌子'
  add.call 'c', 3, '丘匹亚斯'

  add.call 'f', 1, '紫圈'
  add.call 'f', 2, '辉巴'
  add.call 'f', 3, '皮克'
}.call