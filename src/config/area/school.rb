puts __FILE__

school_ground_tiles_text = <<TILES
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
###AAAAA########################################################################
###AAAAA########################################################################
###AAAAA########################################################################
###AAAAA########################################################################
###     B        ######################################                      ###
###                ################################                          ###
###                  ##########################                              ###
###                   ####################                                   ###
###                    ##############                                        ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
####################                                                         ###
####################                                                         ###
####################                                                         ###
####################                                                         ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
########################                                                     ###
################################################################################
TILES


school_ground_area = create_area('map/school/school_ground.bmp', 'map/school_ground.ogg', school_ground_tiles_text)


school_lobby_tiles_text = <<TILES
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
############################BBBBBBBBBBBBBB        ##############################
############################BBBBBBBBBBBBBB         #############################
############################BBBBBBBBBBBBBB          ############################
############################BBBBBBBBBBBBBB    A     ############################
############################BBBBBBBBBBBBBB          ############################
###########################                         ############################
##########################                           ###########################
#########################                            ###########################
########################                              ##########################
#######################                               ##########################
######################                                 #########################
#####################                                  #########################
####################                                    ########################
###################                                      #######################
##################                                        ######################
#################                                          #####################
################                                            ####################
###############                                              ###################
##############                                                ##################
#############                                                  #################
############                                                    ################
###########                                                      ###############
##########                                                        ##############
#########                                                          #############
########                                                               CCCCCCCC#
#######                                                                 CCCCCCC#
######                                                                D  CCCCCC#
#####                                                                     CCCCC#
####                                                                       CCCC#
###                                                                          CC#
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
################################################################################
TILES

school_lobby_area = create_area('map/school/school_lobby.bmp', 'map/school_lobby.ogg', school_lobby_tiles_text)

school_room_tiles_text = <<TILES
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
########################             ###########################################
########################             ###########################################
###      ###############              ##########################################
###      ###############              ##########################################
###      ###############               #########################################
###      ########                      #########################################
###                                     ########################################
###                                      #######################################
###                                       ######################################
###                                         ####################################
###                                          #######################       #####
###                                                                        #####
###                                                                        #####
###                                                                        #####
###                                                                        #####
###                                                                        #####
###                                                                        #####
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###                                                                          ###
###DDDD                                                                      ###
###DDDDD                                                                     ###
###DDDDDD                                                                    ###
###DDDDDDD                                                                   ###
###DDDDDDDDC                                                                 ###
###DDDDDDDD                                                                  ###
###DDDDDDDDD                                                                 ###
###DDDDDDDDD                                                                 ###
###DDDDDDDDDD                                                                ###
###DDDDDDDDDD                                                                ###
################################################################################
TILES

school_room_area = create_area('map/school/school_room.bmp', 'map/school_room.ogg', school_room_tiles_text)

school_ground_area.gateway = {
    :A => {:area => school_lobby_area, :direction => Direction::DOWN}
}

school_lobby_area.gateway = {
    :B => {:area => school_ground_area, :direction => Direction::DOWN},
    :C => {:area => school_room_area, :direction => Direction::RIGHT}
}

school_room_area.gateway = {
    :D => {:area => school_lobby_area, :direction => Direction::LEFT}
}

# �����ڸ���
school_ground_area.add_covering(:image_path => "map/school/school_ground/01.bmp", :x => 1, :y => 40)
school_ground_area.add_covering(:anim => :school_ground_children, :x => 0, :y => 370)

# school_lobby_area.add_covering("map/school/school_lobby/01.bmp", 250, 0)

create_map(:school, [school_ground_area, school_lobby_area, school_room_area])

