# coding: UTF-8

puts __FILE__

hall_wooden_tiles_text = <<TILES
################################################################################
################################################################################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################AAAAAAAAAAAAAAAAAA###############################
###############################                  ###############################
##############################         B         ##################CCCCCCCCCCCC#
############################                      ################CCCCCCCCCCCCC#
###########################                        ###############CCCCCCCCCCCCC#
#########################                            #############CCCCCCCCCCCCC#
#######################                               ############CCCCCCCCCCCCC#
#####################                                   ##########CCCCCCCCCCCCC#
###################                                      #########CCCCCCCCCCCCC#
##################                                                CCCCCCCCCCCCC#
################                                                  CCCCCCCCCCCCC#
###############                                                   CCCCCCCCCCCCC#
#############                                                     CCCCCCCCCCCCC#
############                                                       CCCCCCCCCCCC#
##########                                                          CCCCCCCCCCC#
########                                                             CCCCCCCCCC#
#######                                                               CCCCCCCCC#
#####                                                             D    CCCCCCCC#
####                                                                    CCCCCCC#
##                                                                       CCCCCC#
#                                                                         CCCCC#
#                                                                           CCC#
#                                                                            CC#
#                                                                             C#
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
#                                      X                                       #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
TILES


hall_wooden_area = create_area(:xiujuan_house_1, 'map/xiujuan_house/hall_wooden/HallWooden_0.png',
                               'map/xiujuan_house_1.ogg', hall_wooden_tiles_text)


garret_room_tiles_text = <<TILES
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
#################################                                     ##########
##############################                                                ##
#####################                                                         ##
##################                                                            ##
##############                                                                ##
###########                                                                   ##
##########                                                                    ##
#############                                                                 ##
##############                                                                ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
################                                                              ##
#################                                                             ##
##################                                                            ##
###################                                                           ##
###################                                                           ##
###################                                                           ##
###################                                                      BB   ##
###################                                                     BBBBB ##
###################                                                    BBBBBBBB#
###################                                                   BBBBBBBBB#
###################                                               A  BBBBBBBBBB#
###################                                                  BBBBBBBBBB#
###################                                                 BBBBBBBBBBB#
###################                                                BBBBBBBBBBBB#
###################                                               BBBBBBBBBBBBB#
###################                                              BBBBBBBBBBBBBB#
###################                                             BBBBBBBBBBBBBBB#
###################                                             BBBBBBBBBBBBBBB#
#####################                                           BBBBBBBBBBBBBBB#
#######################                                         BBBBBBBBBBBBBBB#
########################                                        BBBBBBBBBBBBBBB#
########################                                        BBBBBBBBBBBBBBB#
################################################################################
################################################################################
################################################################################
TILES

garret_room_area = create_area(:xiujuan_house_2, 'map/xiujuan_house/garret_room/GarretRoom_0.png',
                               'map/xiujuan_house_2.ogg', garret_room_tiles_text)

inner_room_tiles_text = <<TILES
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
#####################                                        ###################
DDDDDDDD###########                                          ###################
DDDDDDDD##########                                           ###################
DDDDDDDD#########                                             ##################
DDDDDDDD########                                               #################
DDDDDDDD#######                                                #################
DDDDDDDD######                                                  ################
DDDDDDDD#####                                                    ###############
DDDDDDDD                                                          ##############
DDDDDDDD                                                          ##############
DDDDDDDD                                                           #############
DDDDDDDD                                                            ############
DDDDDDD                                                              ###########
DDDDDD                                                                ##########
DDDDD                                                                  #########
DDDD                                                                   #########
DDD  C                                                                  ########
DD                                                                       #######
##                                                                        ######
##                                                                         #####
##                                                                          ####
##                                                                           ###
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
###############                                                               ##
##################                                                            ##
###################                                                           ##
###################                                                           ##
####################                                                          ##
####################                                                          ##
#####################                                                         ##
#####################                                                         ##
######################                                                        ##
########################                                              ##########
##########################                                           ###########
###########################                                          ###########
#############################                                       ############
################################################################################
################################################################################
################################################################################
################################################################################
TILES

inner_room_area = create_area(:xiujuan_house_3, 'map/xiujuan_house/inner_room/InnerRoom_0.png',
                              'map/xiujuan_house_3.ogg', inner_room_tiles_text)

hall_wooden_area.gateway = {
    A: {area: garret_room_area, direction: Direction::LEFT},
    C: {area: inner_room_area, direction: Direction::RIGHT}
}

garret_room_area.gateway = {
    B: {:area => hall_wooden_area, :direction => Direction::DOWN},
}

inner_room_area.gateway = {
    :D => {:area => hall_wooden_area, :direction => Direction::LEFT}
}

hall_wooden_area.add_surface(anim: :xiujuan_house_1_dogs, x: 64, y: 148)
hall_wooden_area.add_surface(image_path: 'map/xiujuan_house/hall_wooden/HallWooden_16.bmp', x: 538, y: 0) # door

garret_room_area.add_surface(anim: :xiujuan_house_2_sunshine, x: 408, y: 0)
garret_room_area.add_surface(anim: :xiujuan_house_2_droplight, x: 314, y: 0)
garret_room_area.add_visual_element(image_path: 'map/xiujuan_house/garret_room/GarretRoom_1.bmp',
                                left: 707, top: 342, y: 399) # 右侧栏杆
garret_room_area.add_visual_element(image_path: 'map/xiujuan_house/garret_room/GarretRoom_32.bmp',
                                    left: 613, top: 431, y: 554) # 左侧栏杆
garret_room_area.add_covering(image_path: 'map/xiujuan_house/garret_room/GarretRoom_33.bmp', x: 0, y: 288) # toys

inner_room_area.add_surface(image_path: 'map/xiujuan_house/inner_room/InnerRoom_10.bmp', x: 0, y: 0) # opened_door
inner_room_area.add_covering(image_path: 'map/xiujuan_house/inner_room/InnerRoom_1.bmp', x: 0, y: 327) # tv
inner_room_area.add_covering(image_path: 'map/xiujuan_house/inner_room/InnerRoom_2.bmp', x: 230, y: 442) # books
inner_room_area.add_visual_element(anim: :xiujuan_house_3_old_man, left: 458, top: 0, y: 146)

create_map(:xiujuan_house, '秀娟家', MapType::VILLAGE, [hall_wooden_area, garret_room_area, inner_room_area])
