# coding: UTF-8

puts __FILE__

tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                      X                   #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
#############                                          #########################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
TILES

area = create_area(:chess, 'map/chess/Back_0.jpg', 'map/chess.ogg', tiles_text)

area.add_surface(image_path: 'map/chess/Back_1.bmp', x: 95, y: 40)
area.add_surface(image_path: 'map/chess/Back_2.bmp', x: 99, y: 239)
area.add_surface(image_path: 'map/chess/Back_14.bmp', x: 28, y: 208)
area.add_surface(anim: :chess_ship_men, x: 0, y: 408)
area.add_surface(anim: :chess_ice_1, x: 0, y: 108)
area.add_surface(anim: :chess_ice_2, x: 319, y: 539)
area.add_surface(anim: :chess_ice_3, x: 602, y: 236)
area.add_surface(anim: :chess_ice_4, x: 4, y: 324)
area.add_surface(anim: :chess_ice_5, x: 595, y: 428)

create_map(:chess, '乱入的空雅弹棋', MapType::SPECIAL, [area])