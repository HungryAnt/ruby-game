# coding: UTF-8

puts __FILE__

ghost_house_0_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA################################################################
#######AAAAAAAAA#################################################           ####
#######AAAAAAAAA################################################            ####
#######AAAAAAAAA#########################################                   ####
######              ###############################                         ####
####       B         ###########################                            ####
####                  ##########################                            ####
###                    ########################                             ####
###                     ###################                                 ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
###                                                                         ####
#############                                                               ####
##############                                                            ######
###############                                                         ########
################                                                      ##########
################                                                      ##########
################                                                      ##########
################                                                      ##########
################                                                      ##########
################                                                      ##########
################                                                      ##########
################                                                       #########
################                                                             ###
################                                                              ##
###############                                                               ##
###############                                                               ##
###############                                                               ##
##############                                                                ##
##########                                                                    ##
##########                                                                    ##
##########                                                                    ##
########                                                                      ##
#######                                                                       ##
#####                                                                         ##
##                                                      X                     ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
##                                                                            ##
################################################################################
TILES


ghost_house_0_area = create_area(:ghost_house_0, 'map/ghost_house/ghost_house_0/GhostHouse0_0.bmp',
                                 'map/ghost_house_0.ogg', ghost_house_0_tiles_text)


ghost_house_1_tiles_text = <<TILES
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
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC##################################################################
#########CCCCC###############                          #########################
#########CCCCC###############                             ######################
#########CCCCC###############                             ######################
#########CCCCC###############                             ######################
#########CCCCC###############                             ######################
#########CCCCC########                                    ######################
#########CCCCC########                                     #####################
#########CCCCC########                                     #####################
#########CCCCC########                                     #####################
#########CCCCC########                                     #####################
#########CCCCCCCCC                                         #####################
#########CCCCCCC                                           #####################
#########CCCCC                                                    ##############
#########CCCC   D                                                 ##############
#########CCC                                                        ############
#########CC                                                         ############
#########C                                                           ###########
#########                                                            ###########
#########                                                            ###########
#########                                                            ###########
#########                                                            ###########
#############                                                        ###########
#############                                                        ###########
#############                                                        ###########
#############                                                         ##########
#############                                                          #########
############                                                            ########
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                             BBBBBBB
############                                                         A   BBBBBBB
############                                                             BBBBBBB
############                                                            BBBBBBBB
############                                                        BBBBBBBBBBBB
################################################################BBBBBBBBBBBBBBBB
################################################################BBBBBBBBBBBBBBBB
TILES

ghost_house_1_area = create_area(:ghost_house_1, 'map/ghost_house/ghost_house_1/GhostHouse1_0.bmp',
                                 'map/ghost_house_1.ogg', ghost_house_1_tiles_text)

ghost_house_2_tiles_text = <<TILES
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
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
################################################################DDDDDDDDDD######
########################################             ###########DDDDDDDDDD######
###############################                        #########DDDDDDDDDD######
##########################                              ########DDDDDDDDDD######
##########################                                 #####DDDDDDDDDD######
##########################                                   ###DDDDDDDDDD######
#########################                                      DDDDDDDDDDD######
########################                                         DDDDDDDDD######
#######################                                         C  DDDDDDD######
###################                                                   DDDD######
##                                                                      DD######
##                                                                        ######
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
TILES

ghost_house_2_area = create_area(:ghost_house_2, 'map/ghost_house/ghost_house_2/GhostHouse2_0.bmp',
                               'map/ghost_house_1.ogg', ghost_house_2_tiles_text)

ghost_house_0_area.gateway = {
    :A => {:area => ghost_house_1_area, :direction => Direction::LEFT}
}

ghost_house_1_area.gateway = {
    :B => {:area => ghost_house_0_area, :direction => Direction::DOWN},
    :C => {:area => ghost_house_2_area, :direction => Direction::LEFT}
}

ghost_house_2_area.gateway = {
    :D => {:area => ghost_house_1_area, :direction => Direction::RIGHT}
}

# 设置遮盖物
ghost_house_0_area.add_covering(:image_path => 'map/ghost_house/ghost_house_0/GhostHouse0_1.bmp',
                                :x => 620, :y => 40)
ghost_house_0_area.add_covering(:image_path => 'map/ghost_house/ghost_house_0/GhostHouse0_27.bmp', :x => 0, :y => 219)
ghost_house_0_area.add_covering(:anim => :ghost_house_0_well, :x => 0, :y => 219)
ghost_house_0_area.add_surface(:anim => :ghost_house_0_ghost_old_man, :x => 65, :y => 86)
ghost_house_0_area.add_surface(:anim => :ghost_house_0_ghost_woman, :x => 477, :y => 100)

ghost_house_1_area.add_surface(:anim => :ghost_house_1_left_ghost, :x => 85, :y => 100)
ghost_house_1_area.add_surface(:anim => :ghost_house_1_right_old_man, :x => 535, :y => 100)
ghost_house_1_area.add_surface(:anim => :ghost_house_1_right_women, :x => 655, :y => 100)

ghost_house_2_area.add_surface(:anim => :ghost_house_2_ghost_boy, :x => 0, :y => 220)
ghost_house_2_area.add_surface(:anim => :ghost_house_2_palm, :x => 300, :y => 199)
ghost_house_2_area.add_surface(:anim => :ghost_house_2_head, :x => 260, :y => 0)

# school_lobby_area.add_covering("map/school/school_lobby/01.bmp", 250, 0)

create_map(:ghost_house, '鬼屋', MapType::VILLAGE,
           [ghost_house_0_area, ghost_house_1_area, ghost_house_2_area])

