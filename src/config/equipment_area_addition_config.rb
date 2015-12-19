lambda {
  area_addition = 'area_addition'

  create_equipment_anims(area_addition, 'pool_1',
                         pattern: 'map/pool/pool_1/Pool_${num}.bmp',
                         up_nums_pair:[4, 7], down_nums_pair:[4, 7], hor_nums_pair:[8, 11])
  set_equipment_properties(area_addition, 'pool_1', left: [-8, 27], up: [0, 25], down: [0, 25], ignore_image: true)

  create_equipment_anims(area_addition, 'pool_2',
                         pattern: 'map/pool/pool_2/Pool2_${num}.bmp',
                         same_nums_pair:[6, 6])
  set_equipment_properties(area_addition, 'pool_2', left: [0, 29], up: [0, 29], down: [0, 29], ignore_image: true)
}.call