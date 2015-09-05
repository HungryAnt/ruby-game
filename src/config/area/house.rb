puts __FILE__

roof1_tiles_text = <<TILES
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
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##   IX                                             ############################
##                                                  ############################
##                                                  ############################
##                                                  ############################
##                                                    ##########################
##                                                      ########################
##                                                        ######################
##                                                          ####################
##                                                            ##################
##                                                                          ####
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                      B   AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
##                                                                          AAAA
################################################################################
################################################################################
################################################################################
################################################################################
TILES

roof1_area = create_area(:house_roof1, 'map/house/roof1/HouseTop_0.bmp', 'map/house_roof.ogg', roof1_tiles_text)
roof1_area.add_surface(:anim => :house_roof1_right_birds, :x => 270, :y => 50)
roof1_area.add_surface(:anim => :house_roof1_left_birds, :x => 61, :y => 53)
roof1_area.add_surface(:anim => :house_roof1_cat_1, :x => 533, :y => 0)
roof1_area.add_surface(:anim => :house_roof1_cat_3, :x => 526, :y => 94)
roof1_area.add_surface(:anim => :house_roof1_cat_2, :x => 646, :y => 149)
roof1_area.add_surface(:anim => :house_roof1_cat_2_eye, :x => 670, :y => 190)

roof2_tiles_text = <<TILES
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
##                                              ################################
##                                               ###############################
##                                                ##############################
##                                                 #############################
##                                                  ############################
##                                                  ############################
##                                                   ###########################
##                                                    ##########################
##                                                     #########################
##                                                      ########################
##                                                       #######################
##                                                        ######################
##                                                         #####################
##                                                          ####################
##                                                           ###################
##                                                            ##################
##                                                             #################
##                                                              ################
##                                                               ###############
##                                                                ##############
##                                                                 #############
BB                                                                  ############
BB                                                                   ###########
BB                                                                    ##########
BB                                                                     #########
BB                                                                      ########
BB                                                                       #######
BB                                                                        ######
BB                                                                    CCC  #####
BB                                                                   CCCCC  ####
BB                                                                  CCCCCCC ####
BB                                                              D   CCCCCCC ####
BB                                                                   CCCCCC ####
BB                                                                    CCCCC ####
BB                                                                     CCC  ####
BB  A                                                                       ####
BB                                                                          ####
BB                                                                          ####
BB                                                                          ####
BB                                                                    ##########
BB                                                                 #############
BB                                                           ###################
BB                                                      ########################
BB                                                 #############################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
TILES

roof2_area = create_area(:house_roof2, 'map/house/roof2/HouseTop2_0.bmp', 'map/house_roof.ogg', roof2_tiles_text)
roof2_area.add_surface(:anim => :house_roof2_birds, :x => 0, :y => 40)

bottom_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
#######################################EEEEE                       #############
#######################################EEEEE                                 ###
#######################################EEEEE                                 ###
#######################################EEEEE                                 ###
#######################################EEEEE                                 ###
#######################################EEEEE                                 ###
#######################################EEEE                                  ###
#######################################EEE     F                             ###
#######################################EE                                    ###
#######################################E                                     ###
######################################                                       ###
####################################                                         ###
###################################                                          ###
###################################                                          ###
##################################                                           ###
################################                                             ###
##############################                                              JJJJ
#############################                                            JJJJJJJ
###DDDDD####################                                             JJJJJJJ
###DDDDDD##################                                             JJJJJJJJ
###DDDDDDD##############                                              JJJJJJJJJJ
###DDDDDDDD                                                          JJJJJJJJJJJ
###DD                                                               JJJJJJJJJJJJ
###     C                                                         JJJJJJJJJJJJJJ
###                                                           JJJJJJJJJJJJJJJJJJ
###                                                         JJJJJJJJJJJJJJJJJJJJ
###                                                        JJJJJJJJJJJJJJJJJJJJJ
###                                                        JJJJJJJJJJJJJJJJJJJJJ
###                                                        JJJJJJJJJJJJJJJJJJJJJ
###                                                        JJJJJJJJJJJJJJJJJJJJJ
###                                                       JJJJJJJJJJJJJJJJJJJJJJ
###                                                      JJJJJJJJJJJJJJJJJJJJJJJ
###                                                 K   JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                     JJJJJJJJJJJJJJJJJJJJJJJJ
###                                                   JJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                  JJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
###                                                 JJJJJJJJJJJJJJJJJJJJJJJJJJJJ
################################################################################
TILES


bottom_area = create_area(:house_bottom, 'map/house/bottom/HouseBottom_0.bmp', 'map/house_bottom.ogg',
                          bottom_tiles_text)
bottom_area.add_covering(:image_path => 'map/house/bottom/HouseBottom_3.bmp', :x => 515, :y => 221)
bottom_area.add_surface(:anim => :house_bottom_frog, :x => 715, :y => 460)
bottom_area.add_covering(:anim => :house_bottom_bucket, :x => 525, :y => 443)

kitchen_outside_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
###              FFFFFFFFFFFFFFFFFFFFFFFFFFFF###################################
###              FFFFFFFFFFFFFFFFFFFFFFFFFFFF###################################
###               FFFFFFFFFFFFFFFFFFFFFFFFFFF###################################
###                        FFFFFFFFFFFFFFFFFF###################################
###                               FFFFFFFFFFF###################################
###                                 FFFFFFFFF###################################
###                            E        FFFFF###################################
###                                       FFF###################################
###                                         F###################################
###                                         ####################################
###                                          ###################################
###                                           #################GGGG#############
###                                            ################GGGGGG###########
###                                             ################GGGGG###########
###                                               ############# GGGGGGGG########
#####                                              ############  GGGGGGGGG######
KKKKKKKKKKKKKKKKKKKK                                 ##########   GGGGGGGGGG####
KKKKKKKKKKKKKKKKKKKK                                    ####        GGGGGGGGG###
KKKKKKKKKKKKKKKKKKKK                                                 GGGGGGGG###
KKKKKKKKKKKKKKKKKKKK                                           H       GGGGGG###
KKKKKKKKKKKKKKKKKKKK                                                     GGGG###
KKKKKKKKKKKKKKKKKKKK                                                         ###
KKKKKKKKKKKKKKKKKKKK                                                         ###
KKKKKKKKKKKKKKKKKKKK   J                                                     ###
KKKKKKKKKKKKKKKKKKKK                                                         ###
KKKKKKKKKKKKKKKKKKKK                                                         ###
KKKKKKKKKKKKKKKKKKKK                                                         ###
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
KKKKKKKKKKKKKKKKKKKK                                                          ##
#######################                                                       ##
#######################                                                       ##
########################                                                      ##
########################                                                      ##
#########################                                                     ##
#########################                                                     ##
##########################                                                    ##
###########################                                                   ##
###########################                                                   ##
############################                                                  ##
#############################                                                 ##
##################################                                         #####
################################################################################
################################################################################
################################################################################
TILES

kitchen_outside_area = create_area(:house_kitchen_outside, 'map/house/kitchen_outside/KitchenOutside_0.bmp',
                                   'map/house_kitchen_outside.ogg', kitchen_outside_tiles_text)
kitchen_outside_area.add_surface(:anim => :house_kitchen_door, :x => 620, :y => 0)
kitchen_outside_area.add_covering(:image_path => 'map/house/kitchen_outside/KitchenOutside_2.bmp', :x => 0, :y => 233)


kitchen_inside_tiles_text = <<TILES
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
############################################              ######################
#######################################                   ######################
#######################################                          ###############
#######################################                          ###############
###################################################       ######################
###################################################       ######################
###################################################       ######################
###################################################       ######################
###################################################       ######################
########IIIIIIIII##################################       ######################
########IIIIIIIII##################################       ######################
########IIIIIIIII##################################       ######################
########           ################################       ######################
########           ################################       ######################
########           ################################       ######################
########           ################################       ######################
########           ################################       ######################
########                                                    ####################
######                                                                        ##
##                                                                            ##
##                                                                            ##
HH                                                                            ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH  G                                                                        ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HHH                                                                           ##
HH                                                                            ##
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
TILES

kitchen_inside_area = create_area(:house_kitchen_inside, 'map/house/kitchen_inside/KitchenInside_0.bmp',
                                  'map/house_kitchen_inside.ogg', kitchen_inside_tiles_text)
kitchen_inside_area.add_surface(:anim => :house_kitchen_sink, :x => 60, :y => 100)
kitchen_inside_area.add_surface(:anim => :house_kitchen_pot, :x => 630, :y => 40)
kitchen_inside_area.add_surface(:anim => :house_kitchen_fire, :x => 660, :y => 200)


roof1_area.gateway = {
    :A => {:area => roof2_area, :direction => Direction::RIGHT}
}

roof2_area.gateway = {
    :B => {:area => roof1_area, :direction => Direction::LEFT},
    :C => {:area => bottom_area, :direction => Direction::RIGHT}
}

bottom_area.gateway = {
    :D => {:area => roof2_area, :direction => Direction::LEFT},
    :E => {:area => kitchen_outside_area, :direction => Direction::LEFT},
    :J => {:area => kitchen_outside_area, :direction => Direction::RIGHT},
}

kitchen_outside_area.gateway = {
    :F => {:area => bottom_area, :direction => Direction::RIGHT},
    :K => {:area => bottom_area, :direction => Direction::LEFT},
    :G => {:area => kitchen_inside_area, :direction => Direction::RIGHT},
}

kitchen_inside_area.gateway = {
    :H => {:area => kitchen_outside_area, :direction => Direction::LEFT},
    :I => {:area => roof1_area, :direction => Direction::DOWN},
}

create_map(:house, [roof1_area, roof2_area, bottom_area, kitchen_outside_area, kitchen_inside_area])