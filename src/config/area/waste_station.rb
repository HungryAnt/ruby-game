# coding: UTF-8

puts __FILE__

tiles_text = <<TILES
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
################                                                   #############
################                                                    ############
################                                                     ###########
#############                                                          #########
##########                                                                     #
######                                                                         #
###                                                                            #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                 X                            #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
TILES

area = create_area(:waste_station, 'map/waste_station/WasteMesh_0.png', 'map/waste_station.ogg', tiles_text)

# 设置遮盖物
area.add_surface(:anim => :waste_clerk, :x => 278, :y => 87)

create_map(:waste_station, '垃圾回收站', MapType::SPECIAL, [area])