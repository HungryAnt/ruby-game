# coding: UTF-8

lambda {
  add = lambda do |flag, num, name, height|
    pet_type = "pet_#{flag}#{num}".to_sym
    pet_type_info = PetTypeInfo.new pet_type, name, height
    PetTypeInfo.put pet_type, pet_type_info
    EquipmentDefinition.set_item_image pet_type, "pet/#{flag}#{num}/#{num}_0.bmp"
  end

  add.call 'c', 1, '佳茹贝贝', 24
  add.call 'c', 2, '绿蚌子', 26
  add.call 'c', 3, '丘匹亚斯', 34
  add.call 'c', 37, '亚格尼斯', 58

  add.call 'f', 1, '紫圈', 24
  add.call 'f', 2, '辉巴', 20
  add.call 'f', 3, '皮克', 37

  add.call 'g', 1, '达伊', 23
  add.call 'g', 2, '萍萍', 25
  add.call 'g', 3, '紫尾巴', 26
  add.call 'g', 4, '明明', 25
}.call