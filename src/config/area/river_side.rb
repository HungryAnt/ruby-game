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
############                                          ##########################
############                                          ##########################
############                                           #########################
############                                             #######################
############                                               #####################
############                                                ####################
############                                                 ###################
############                                                   #################
############                                                      ##############
############                                                         ###########
############                                                          ##########
############                                                           #########
############                                                             #######
############                                                              ######
##########                                                                 #####
##########                                                                  ####
##########                                                                  ####
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                                   ###
##########                                                        X          ###
##########                                                                    ##
##########                                                                    ##
##########                                                                    ##
##############                                                                ##
################                                                              ##
###################                                                           ##
#####################                                                         ##
######################                                                        ##
#########################                                                     ##
##########################                                                    ##
###########################                                                   ##
#############################                                                 ##
##############################                                                ##
###############################                                               ##
################################                                              ##
#################################                                             ##
##################################                                            ##
##################################                                            ##
##################################                                            ##
################################################################################
################################################################################
################################################################################
TILES

area = create_area(:river_side, 'map/river_side/Riverside_0.png', 'map/river_side.ogg', tiles_text)

area.add_covering(anim: :river_side_lobster, x: 0, y: 390) # 龙虾
area.add_surface(anim: :river_side_fish, x: 170, y: 90) # 游泳的鱼
area.add_surface(anim: :river_side_tortoises, x: 305, y: 25) # 乌龟群
area.add_surface(anim: :river_side_tortoise, x: 530, y: 55) # 一只乌龟
area.add_visual_element(image_path: 'map/river_side/Riverside_1.bmp', left: 0, top: 20, y: 268)

create_map(:river_side, '小池塘', MapType::SPECIAL, [area])