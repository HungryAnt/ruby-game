# coding: UTF-8

lambda {
  add = lambda do |id, name|
    pet_type_info = PetTypeInfo.new id, name
    PetTypeInfo.put id, pet_type_info
  end

  add.call 1, '佳茹贝贝'
  add.call 2, '绿蚌子'
  add.call 3, '丘匹亚斯'
}.call