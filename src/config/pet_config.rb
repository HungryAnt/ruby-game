# coding: UTF-8

lambda {
  add = lambda do |id, name|
    pet_type_info = PetTypeInfo.new id, name
    PetTypeInfo.put id, pet_type_info
  end

  add.call 'c1', '佳茹贝贝'
  add.call 'c2', '绿蚌子'
  add.call 'c3', '丘匹亚斯'

  add.call 'f1', '紫圈'
  add.call 'f2', '辉巴'
  add.call 'f3', '皮克'
}.call