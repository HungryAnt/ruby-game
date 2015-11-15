# coding: UTF-8

puts __FILE__

rainy_day_1_tiles_text = <<TILES
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
#################           ####################################################
###############             ####################################################
#############               ####################################################
###########                 ####################################################
#########                   ####################################################
#######         X           ####################################################
#####                       ####################################################
###                         ####################################################
##                          ####################################################
##                          ####################################################
##                           ###################################################
##                            ##################################################
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
##                                                                          AAAA
##                                                                          AAAA
##                                                                       B  AAAA
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
##                                                                          AAAA
################################################################################
################################################################################
TILES


rainy_day_1_area = create_area(:rainy_day_1, 'map/rainy_day/rainy_day_1/RainyDay1_0.bmp', 'map/rainy_day.ogg',
                           rainy_day_1_tiles_text)

rainy_day_1_area.add_surface(:anim => :rainy_day_1_rain, :x => 57, :y => 0)


rainy_day_2_tiles_text = <<TILES
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
################################################################################
################################################################################
################################################################################
################################################################################
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB  A                                                                       ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
BBBB                                                                          ##
################################################################################
################################################################################
TILES

rainy_day_2_area = create_area(:rainy_day_2, 'map/rainy_day/rainy_day_2/RainyDay2_0.bmp', 'map/rainy_day.ogg',
                               rainy_day_2_tiles_text)

rainy_day_2_area.add_surface(:anim => :rainy_day_2_rain, :x => 0, :y => 0)

rainy_day_1_area.gateway = {
    :A => {:area => rainy_day_2_area, :direction => Direction::RIGHT}
}

rainy_day_2_area.gateway = {
    :B => {:area => rainy_day_1_area, :direction => Direction::LEFT},
}

create_map(:rainy_day, '雨天', MapType::VILLAGE, [rainy_day_1_area, rainy_day_2_area])

