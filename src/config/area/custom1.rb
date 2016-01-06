# coding: UTF-8

puts __FILE__

custom1_roof_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
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
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                       X      #
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
#                                                                              #
#AAAAAAAAAAAA                                                                  #
#AAAAAAAAAAAAA                                                                 #
#AAAAAAAAAAAAAA B                                                              #
#AAAAAAAAAAAAAA                                                                #
#AAAAAAAAAAAAAAA                                                               #
#AAAAAAAAAAAAAAA                                                               #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
#AAAAAAAAAAAAAAAA                                                              #
################################################################################
################################################################################
################################################################################
TILES


custom1_roof_area = create_area(:custom1_roof, 'map/custom1/roof.jpg', 'map/custom1.ogg', custom1_roof_tiles_text)


custom1_tree_tiles_text = <<TILES
################################################################################
##########################################BBBBBBBBBBBBBBBBBBBBBBBBBB############
##                                        BBBBBBBBBBBBBBBBBBBBBBBBBB          ##
##                                        BBBBBBBBBBBBBBBBBBBBBBBBBB          ##
##                                                                            ##
##                                                   A                        ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
################################################################################
################################################################################
################################################################################
TILES

custom1_tree_area = create_area(:custom1_tree, 'map/custom1/tree.jpg', 'map/custom1.ogg', custom1_tree_tiles_text)

custom1_roof_area.gateway = {
    :A => {:area => custom1_tree_area, :direction => Direction::DOWN}
}

custom1_tree_area.gateway = {
    :B => {:area => custom1_roof_area, :direction => Direction::RIGHT},
}

create_map(:custom1, '萌萌的地图 by 子轩', MapType::VILLAGE, [custom1_roof_area, custom1_tree_area])

