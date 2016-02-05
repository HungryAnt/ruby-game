# coding: UTF-8

puts __FILE__

colliery_1_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
##############################            ######################################
##############################            ######################################
##############################             #####################################
##############################              ####################################
##############################                ##################################
##############################                  ################################
##############################                   ###############################
##############################                     #############################
##############################                       ###########################
##############################                           #######################
##############################                                                ##
#############################                                                 ##
###################                                                           ##
#################                                                             ##
################                                                        AAAAAAA#
###############                                                         AAAAAAA#
#############                                                           AAAAAAA#
#########                                                               AAAAAAA#
########                                                                AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                    B AAAAAAA#
##       X                                                              AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
##                                                                      AAAAAAA#
#####                                                                   AAAAAAA#
########                                                                      ##
##########                                                                    ##
############                                                                  ##
#############                                                                 ##
##############                                                                ##
##################                                                            ##
#####################                                                         ##
#####################                                                         ##
################################################################################
################################################################################
################################################################################
TILES

colliery_1_area = create_area(:colliery_1, 'map/colliery/colliery1/Colliery1_0.jpg', 'map/colliery1.ogg',
                              colliery_1_tiles_text)
colliery_1_area.add_surface(anim: :colliery_1_lamp, x:439, y:0)
colliery_1_area.add_covering(image_path: 'map/colliery/colliery1/Colliery1_3.bmp', x:0, y:420)
colliery_1_area.add_visual_element(image_path: 'map/colliery/colliery1/Colliery1_1.bmp',
                                   left: 650, top: 200, y: 335)

colliery_2_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC############EEEEEEEEEEEE###################################
#########CCCCCCCCCCCC            EEEEEEEEEEEE###################################
#########                                    ###################################
#########     D                       F      ###################################
########                                      ##################################
########                                      ##################################
########                                      ##################################
########                                       #################################
#######                                          ###############################
#######                                            #############################
######                                              ############################
######                                                 #########################
#####                                                      #####################
#####                                                         ##################
####                                                                          ##
####                                                                          ##
###                                                                           ##
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
##        A                                                                   ##
##BBBBBB                                                                      ##
##BBBBBBBBB                                                                   ##
##BBBBBBBBBBB                                                                 ##
##BBBBBBBBBBBB                                                                ##
##BBBBBBBBBBBBB                                                               ##
##BBBBBBBBBBBBBB                                                              ##
##BBBBBBBBBBBBBB                                                              ##
##BBBBBBBBBBBBBBB                                                             ##
##BBBBBBBBBBBBBBB                                                             ##
##BBBBBBBBBBBBBBBB                                                            ##
##BBBBBBBBBBBBBBBB                                                            ##
##BBBBBBBBBBBBBBBBB                                                           ##
##BBBBBBBBBBBBBBBBB                                                           ##
##BBBBBBBBBBBBBBBBBB                                                          ##
##BBBBBBBBBBBBBBBBBB                                                          ##
##BBBBBBBBBBBBBBBBBB                                                          ##
################################################################################
################################################################################
################################################################################
TILES

colliery_2_area = create_area(:colliery_2, 'map/colliery/colliery2/Colliery2_0.jpg', 'map/colliery1.ogg',
                              colliery_2_tiles_text)
colliery_2_area.add_surface(anim: :colliery_2_miner, x: 280, y: 20)
colliery_2_area.add_covering(image_path: 'map/colliery/colliery2/Colliery2_4.bmp', x: 0, y: 430)

colliery_3_tiles_text = <<TILES
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
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                                                                           ##
###                  C                                                        ##
###                                                                           ##
###DDDDDDDDDDDDDDDDDD                                                         ##
###DDDDDDDDDDDDDDDDDDDDDDDDD                                                  ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDD                                                ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDDD                                               ##
###DDDDDDDDDDDDDDDDDDDDDDDDDDDDD################################################
###DDDDDDDDDDDDDDDDDDDDDDDDDDDDD################################################
################################################################################
TILES

colliery_3_area = create_area(:colliery_3, 'map/colliery/colliery3/Colliery3_0.jpg', 'map/colliery3.ogg',
                              colliery_3_tiles_text)
colliery_3_area.add_visual_element(image_path: 'map/colliery/colliery3/Colliery3_1.bmp',
                                   left: 40, top: 300, y: 426)
colliery_3_area.add_visual_element(image_path: 'map/colliery/colliery3/Colliery3_3.bmp',
                                   left: 520, top: 380, y: 478)
colliery_3_area.add_visual_element(image_path: 'map/colliery/colliery3/Colliery3_4.bmp',
                                   left: 0, top: 0, y: 396)
colliery_3_area.add_visual_element(image_path: 'map/colliery/colliery3/Colliery3_5.bmp',
                                   left: 600, top: 0, y: 520)
colliery_3_area.add_visual_element(anim: :colliery_3_traffic_light, left: 360, top: 100, y: 254)


colliery_4_tiles_text = <<TILES
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
####FFFFFFFFF                                                       GGGGGGGGGG##
####FFFFFFFFF                                                       GGGGGGGGGG##
####FFFFFFFFF E                                                   H GGGGGGGGGG##
####FFFFFFFFF                                                       GGGGGGGGGG##
####FFFFFFFFF                                                       GGGGGGGGGG##
####FFFFFFFFF                                                       GGGGGGGGGG##
####FFFFF                                                              GGGGGGG##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                          ##
####                                                                         ###
####                                                                        ####
######                                                                     #####
#######                                                                   ######
########                                                                 #######
##########                                                              ########
###########                                                           ##########
############                                                        ############
#############                                                      #############
##############                                                    ##############
###############                                                  ###############
#################                                              #################
##################                                            ##################
###################                                         ####################
################################################################################
################################################################################
################################################################################
TILES

colliery_4_area = create_area(:colliery_4, 'map/colliery/colliery4/Colliery4_0.jpg', 'map/colliery4.ogg',
                              colliery_4_tiles_text)
colliery_4_area.add_covering(image_path: 'map/colliery/colliery4/Colliery4_3.bmp', x: 0, y: 0)
colliery_4_area.add_covering(image_path: 'map/colliery/colliery4/Colliery4_4.bmp', x: 600, y: 0)


colliery_5_tiles_text = <<TILES
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
###HHHHHHHHHH                                                               ####
###HHHHHHHHHH                                                               ####
###HHHHHHHHHH                                                               ####
###HHHHHHHHHH G                                                             ####
###HHHHHHHHHH                                                               ####
###HHHHHHHHHH                                                               ####
###HHHHHHHHHH                                                               ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
####                                                                        ####
#####                                                                       ####
######                                                                      ####
#######                                                                     ####
########                                                                    ####
#########                                                                   ####
##########                                                                  ####
###########                                                                 ####
############                                                                ####
#############                                                               ####
##############                                                              ####
###############                                                             ####
################                                                            ####
#################                                                           ####
###################                                                         ####
################################################################################
################################################################################
################################################################################
TILES

colliery_5_area = create_area(:colliery_5, 'map/colliery/colliery5/Colliery5_0.jpg', 'map/colliery4.ogg',
                              colliery_5_tiles_text)
colliery_5_area.add_visual_element(image_path: 'map/colliery/colliery5/Colliery5_2.bmp',
                                   left: 640, top: 290, y: 418)
colliery_5_area.add_covering(image_path: 'map/colliery/colliery5/Colliery5_3.bmp', x: 0, y: 0)
colliery_5_area.add_visual_element(image_path: 'map/colliery/colliery5/Colliery5_4.bmp',
                                   left: 640, top: 0, y: 418)
colliery_5_area.add_visual_element(anim: :colliery_5_traffic_light, left: 340, top: 100, y: 252)

colliery_1_area.gateway = {
    A: {area: colliery_2_area, direction: Direction::RIGHT}
}

colliery_2_area.gateway = {
    B: {area: colliery_1_area, direction: Direction::LEFT},
    C: {area: colliery_3_area, direction: Direction::UP},
    E: {area: colliery_4_area, direction: Direction::RIGHT}
}

colliery_3_area.gateway = {
    D: {area: colliery_2_area, direction: Direction::DOWN},
}

colliery_4_area.gateway = {
    F: {area: colliery_2_area, direction: Direction::DOWN},
    G: {area: colliery_5_area, direction: Direction::RIGHT},
}

colliery_5_area.gateway = {
    H: {area: colliery_4_area, direction: Direction::LEFT}
}

create_map(:colliery, '矿区', MapType::VILLAGE,
           [colliery_1_area, colliery_2_area, colliery_3_area, colliery_4_area, colliery_5_area])