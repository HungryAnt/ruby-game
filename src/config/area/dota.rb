# coding: UTF-8

puts __FILE__

dota_text = <<TILES
########################################################################################################################################
########################################################################################################################################
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                 X                                                                  ##
##                                                                                                                                    ##
##                                                                                                                                    ##
##                                                                                                                                    ##
########################################################################################################################################
########################################################################################################################################
########################################################################################################################################
TILES

dota_area = create_area(:custom1_tree, 'map/dota/dota.jpg', nil, dota_text)
dota_area.scroll_background = true


create_map(:dota, 'Dota', MapType::VILLAGE, [dota_area])

