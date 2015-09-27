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
#############################          #########################################
#############################            #######################################
########################                   ############             ############
###                                                                     ########
##                                                                         #####
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
####                                                                          ##
#####                                                                         ##
#######                                                                       ##
#########                                                                     ##
###########                                                                   ##
#############                                                                 ##
###############                                                               ##
#################                                                             ##
###################                                                           ##
#####################                                                         ##
#######################                                                       ##
#########################                                                     ##
###########################                                                   ##
#############################                                                 ##
###############################                                               ##
#################################                                             ##
###################################                                           ##
#####################################                                         ##
#######################################                                       ##
########################################                                      ##
################################################################################
################################################################################
TILES

area = create_area(:cart, 'map/cart/cart.bmp', 'map/cart.ogg', tiles_text)

area.add_surface(:image_path => 'map/cart/Cart_1.bmp', :x => 0, :y => 0)
area.add_surface(:image_path => 'map/cart/Cart_2.bmp', :x => 384, :y => 68)
area.add_surface(:image_path => 'map/cart/cart.bmp', :x => 0, :y => 0)
area.add_surface(:anim => :cart_wheel, :x => 0, :y => 455)

create_map(:cart, '村民的牛拉车', MapType::SPECIAL, [area])