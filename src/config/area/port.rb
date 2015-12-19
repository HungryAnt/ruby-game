# coding: UTF-8

puts __FILE__

port_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##########################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA####################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##################################
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA##########                       #
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA                                 #
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA                                      #
####AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA                                           #
####AAAAAAAAAAAAAAAAAAAAAAAAAAA                                                #
####AAAAAAAAAAAAAAAAAAA                                                        #
####AAAAAAAAAAAAA       B                                                      #
####AAAAAAAAAAAAA                                                              #
####AAAAA                                                                  X   #
####                                                                           #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                         ######
#                                                                       ########
#                                                                     ##########
#                                                                   ############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
###                                                               ##############
#####                                                            ###############
#######                                                          ###############
#########                                                        ###############
############                                                  ##################
#############                                                ###################
##############                                             #####################
#################                                         ######################
#####################                                    #######################
######################                                  ########################
##########################                              ########################
#############################                          #########################
##############################                        ##########################
################################################################################
TILES

port_area = create_area(:port, 'map/port/port/Port_0.png', 'map/port.ogg', port_tiles_text)

ship_deck_tiles_text = <<TILES
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
####################################################            ################
##################################################                  ############
################################################                        ########
##############################################                             #####
###############################                                             BBB#
############################                                                BBB#
#########################                                                   BBB#
#######################                                                     BBB#
#####################                                                       BBB#
##################                                                          BBB#
################                                                            BBB#
##############                                                              BBB#
###########                                                                 BBB#
#########                                                                   BBB#
#######                                                                     BBB#
######                                                                      BBB#
#####                                                                     A BBB#
####                                                                        BBB#
###                                                                         BBB#
###                                                                         BBB#
######                                                                      BBB#
########                                                                    BBB#
#########                                                                   BBB#
##########                                                                  BBB#
###########                                                                 BBB#
#############                                                               BBB#
###############                                                             BBB#
###############                                                             BB##
################                                                              ##
##################                                                           ###
#####################                                                       ####
#######################                                                    #####
########################                                                  ######
#########################                                                #######
#########################                                               ########
#########################                                              #########
#############################                                         ##########
#####################################                              #############
##############################################                  ################
################################################################################
################################################################################
################################################################################
################################################################################
TILES

ship_deck_area = create_area(:ship_deck, 'map/port/ship_deck/ShipDeck_0.png', 'map/port.ogg', ship_deck_tiles_text)

port_area.gateway = {
    :A => {:area => ship_deck_area, :direction => Direction::LEFT}
}

ship_deck_area.gateway = {
    :B => {:area => port_area, :direction => Direction::DOWN},
}

# 设置遮盖物
port_area.add_surface(anim: :port_ships, x: 0, y: 0)
port_area.add_surface(anim: :port_wave, x: 0, y: 491)

port_area.add_visual_element(image_path: 'map/port/port/Port_4.bmp', left: 100, top: 305, y:326)
port_area.add_visual_element(image_path: 'map/port/port/Port_5.bmp', left: 425, top: 245, y:262)
port_area.add_visual_element(image_path: 'map/port/port/Port_6.bmp', left: 545, top: 215, y:225)

port_area.add_covering(image_path: 'map/port/port/Port_3.bmp', :x => 540, :y => 340)

ship_deck_area.add_covering(image_path: 'map/port/ship_deck/ShipDeck_2.bmp', :x => 0, :y => 350)
ship_deck_area.add_covering(image_path: 'map/port/ship_deck/ShipDeck_3.bmp', :x => 280, :y => 470)

ship_deck_area.add_surface(anim: :ship_deck_boat, :x => 0, :y => 0) # 小船
ship_deck_area.add_surface(anim: :ship_deck_right_octopus, :x => 436, :y => 87) # 右侧章鱼
ship_deck_area.add_surface(anim: :ship_deck_left_octopus, :x => 365, :y => 105) # 左侧章鱼

create_map(:port, '野菜村码头', MapType::VILLAGE, [port_area, ship_deck_area])
