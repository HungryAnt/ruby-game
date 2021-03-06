# coding: UTF-8

puts __FILE__

outside_tiles_text = <<TILES
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
################################AAAAA###########################################
################################AAAAA###########################################
################################AAAAA###########################################
################################AAAAA###########################################
################################AAAAA###########################################
################################AAAAA###########################################
################################AAAAA###########################################
###############                 B    ###########################################
###############                      ###########################################
###                                  ###########################################
###                                   ##########################################
###                                    #########################################
###                                     ########################################
###                                      #######################################
###                                       ######################################
###                                        #####################################
#######                                       ##################################
#######                                          ###############################
#########                                             ##########################
#########                                                 ######################
#########                                                    ###################
#########                                                        ###############
#########                                                            ###########
#########                X                                             #########
#########                                                                 ######
#########                                                                    ###
#########                                                                    ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##################                                                         #####
#######################                                                  #######
#######################                                                #########
#######################                                              ###########
#######################                                            #############
#######################                                          ###############
#######################                                        #################
#######################                                      ###################
#######################                                     ####################
#######################                                   ######################
################################################################################
TILES


outside_area = create_area(:outside, 'map/church/outside.bmp', 'map/church_outside.ogg', outside_tiles_text)


inside_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
####                     #######################################################
###                            #######        #########     ####################
#BBBB                          ####            #######      ####################
#BBBBB                                                      ####################
#BBBBBA                                                       ##################
#BBBBB                                                          ################
#BBBBB                                                          ################
###BB                                                            ###############
###                                                              ###############
###                                                             ################
###                                                          ###################
###                                                       ######################
###                                                      #######################
###                                                      #######################
###                                                      #######################
###                                                      #######################
###                                                      #######################
###                                                      #######################
###                                                   ##########################
###                                                 ############################
###                                               ##############################
###                                             ################################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                 ############################
###                                                   ##########################
###                                                   ##########################
###                                                   ##########################
###                                                   ##########################
###                                                   ##########################
###                                                   ##########################
###                                                   ##########################
###                                                     ########################
###                                                                  ###########
###                                                                   ##########
###                                                                   ##########
###                                                                   ##########
################################################################################
TILES

inside_area = create_area(:inside, 'map/church/inside.bmp', 'map/church_inside.ogg', inside_tiles_text)

outside_area.gateway = {
    :A => {:area => inside_area, :direction => Direction::RIGHT}
}

inside_area.gateway = {
    :B => {:area => outside_area, :direction => Direction::DOWN},
}

# 设置遮盖物
outside_area.add_covering(:image_path => 'map/church/outside/snowman.bmp', :x => 0, :y => 299)
outside_area.add_covering(:anim => :church_outside_cat, :x => 560, :y => 420)

inside_area.add_surface(:anim => :church_inside_window, :x => 580, :y => 0)
inside_area.add_covering(:anim => :church_inside_treetop, :x => 640, :y => 0)

inside_area.add_visual_element(image_path: 'map/church/inside/X-Mas00_ChurchIn_7.bmp',
                               left: 448, top: 240, y: 367) # 挡板

inside_area.add_visual_element(:anim => :church_inside_bear, left: 523, top: 220, y:379)

create_map(:church, '礼拜堂', MapType::VILLAGE, [outside_area, inside_area])

