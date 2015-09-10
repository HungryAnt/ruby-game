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
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
##############################                     #############################
##############################                     #############################
#############################                       ############################
###                    ######                       ####                     ###
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
###                                                                          ###
###                                                                          ###
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
##################                                             #################
################################################################################
TILES

area = create_area(:pay, 'map/seven_star_hall/SevenStartHall_0.bmp', 'map/seven_start_hall.ogg', tiles_text)
area.add_surface(:anim => :hall_left_lantern, :x => 0, :y => 40)
area.add_surface(:anim => :hall_right_lantern, :x => 590, :y => 40)
area.add_covering(:anim => :hall_immortal, :x => 287, :y => 13)
area.add_covering(:image_path => 'map/seven_star_hall/SevenStartHall_1.bmp', :x => 53, :y => 356)
area.add_covering(:image_path => 'map/seven_star_hall/SevenStartHall_2.bmp', :x => 640, :y => 356)

create_map(:seven_star_hall, '七星堂', MapType::SPECIAL, [area])