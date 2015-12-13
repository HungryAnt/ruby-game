# coding: UTF-8

puts __FILE__

snow_village_1_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
####################                         ###################################
############                                  ###########AAAAAAAAA##############
#                                              ##########AAAAAAAAA##############
#                                               #########AAAAAAAAA##############
#                                                ########AAAAAAAAA##############
#                                                 #######AAAAAAAAA##############
#                                                  ######AAAAAAAAA##############
#                                                          B      ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                 ##############
#                                                                ###############
#                                                                ###############
#                                                                ###############
#                                                                ###############
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                               ################
#                                                                ###############
##########                                                         #############
###########                                                         ############
############                                                                   #
#############                                                                  #
##############                                                                 #
##############                                                                 #
################                                                               #
#################                                                              #
##################                                                             #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                   X        #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
###################                                                            #
################################################################################
################################################################################
TILES

area_snow_village_1 = create_area(:snow_village_1,
                                 'map/snow_village/snow_village_1/SnowFlowerVillage1_0.bmp', 'map/snow_village_1.ogg',
                                 snow_village_1_tiles_text)

snow_village_2_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
##########################################################################CCCCC#
##########################################################################CCCCC#
##########################################################################CCCCC#
################################################################          CCCCC#
################################################################          D    #
#################################################################              #
########################################################################       #
########################################      ##########################       #
#####################################         ##########################       #
##########################                    ##########################       #
########################                      ##########################       #
#####################                         #####################            #
########BBBBBB#######                          ##################              #
########BBBBBB                                  ################               #
########BBBBBB                                                                 #
########BBBBBB                                                                 #
########BBBBBB                                                                 #
########BBBBBB                                                                 #
########BBBBBB A                                                               #
########BBBBBB                                                                 #
########                                                                       #
########                                                                       #
#######                                                                        #
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
################################################################################
################################################################################
TILES

area_snow_village_2 = create_area(:snow_village_2,
                                  'map/snow_village/snow_village_2/SnowFlowerVillage2_0.bmp', 'map/snow_village_2.ogg',
                                  snow_village_2_tiles_text)

snow_village_3_tiles_text = <<TILES
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
#######################################################EEEEEE###################
#######################################################EEEEEE###################
#######################################################EEEEEE###################
#######################################################EEEEEE###################
#######################################################EEEEEE###################
#######################################################EEEEEE###################
#######################################################EEEEEE###################
##############################                #########EEEEEE###################
#######################                       #########EEEEEE###################
#################                                            ###################
#################                                      F                ########
################                                                        ########
################                                                        ########
###############                                                         ########
#############                                                            #######
##########                                                               #######
#######                                                                   ######
#####                                                                     ######
###                                                                        #####
#                                                                          #####
#                                                                          #####
#                                                                          #####
#                                                                    I     #####
#                                                                          #####
#                                                                          #####
#                                                                          #####
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
#                      C                                                       #
#                                                                              #
#            DDDDDDDDDDDDDDDDDDDDD                                             #
#            DDDDDDDDDDDDDDDDDDDDD                                             #
#            DDDDDDDDDDDDDDDDDDDDD                                             #
#           DDDDDDDDDDDDDDDDDDDDDD                                             #
#          DDDDDDDDDDDDDDDDDDDDDDD                                             #
#          DDDDDDDDDDDDDDDDDDDDDDD                                             #
###########DDDDDDDDDDDDDDDDDDDDDDD##############################################
################################################################################
TILES

area_snow_village_3 = create_area(:snow_village_3,
                                  'map/snow_village/snow_village_3/SnowFlowerVillage3_0.bmp', 'map/snow_village_3.ogg',
                                  snow_village_3_tiles_text)


snow_village_4_tiles_text = <<TILES
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF############################################
####################FFFFFFFFFFFFFFFF####   #####################################
####################FFFFFFFFFFFFFFFF#      #####################################
######GGGGGGGGGGG   FFFFFFFFFFFFFFFF       ##########   ########################
######GGGGGGGGGGG                          ###           #######################
######GGGGGGGGGGG        E                 ######       ########################
######GGGGGGGGGGG H                        #######      ##    ##################
######GGGGGGGGGGG                          #########  ####     #################
#########GGGGGG                            #########  ####        ##############
#########GGGGGG                            #########  ####            ##########
#########GGGGGG                            #########  ####            ##########
#########GG                                #########  ####            ##########
######                                     #########  ###             ##########
#                                            #######  #                    #####
#                                                                           ####
#                                                                             ##
#                                                                              #
#                                                                              #
#                                                                          #####
#                                                                        #######
#                                                                     ##########
#                                                                    ###########
#                                                                   ############
#                                                                  #############
#                                                                 ##############
#                                                                ###############
#                                                                ###############
#                                                               ################
#                                                               ################
#                                                            ###################
#                                                          #####################
#                                                       ########################
#                                                       ########################
#                                                      #########################
#                                                 ##############################
#                                                ###############################
#                                               ################################
#                                               ################################
#                                               ################################
#                                               ################################
#                                               ################################
#                                               ################################
#                                               ################################
#                                               ################################
################################################################################
################################################################################
TILES

area_snow_village_4 = create_area(:snow_village_4,
                                  'map/snow_village/snow_village_4/SnowFlowerVillage4_0.bmp', 'map/snow_village_4.ogg',
                                  snow_village_4_tiles_text)

snow_village_5_tiles_text = <<TILES
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
####################################           #################################
#################HHHHHHHHHHHHHH                  ###############################
#################HHHHHHHHHHHHHH                      ###########################
#################HHHHHHHHHHHHHH                        #########################
#################HHHHHHHHHHHHHH                         ########################
#################HHHHHHHHHHHHHH  G                          ####################
#################HHHHHHHHHHHHHH                             ####################
#################HHHHHHHHHHHHHH                                      ###########
#################                                                      #########
#################                                                      #########
#################                                                      #########
#################                                                      #########
#################                                                      #########
#################                                                      #########
#################                                                      #########
#################                                                      IIIII####
#################                                                   IIIIIIII####
#################                                                   IIIIIIII####
#################                                                   IIIIIIII####
#################                                                   IIIIIIII####
################                                                    III#########
##########                                                          II##########
##########                                                       ###############
##########                                                       ###############
##########                                                      ################
##########                                                      ################
##########                                                      ################
##########                                                    ##################
##################                                         #####################
###################                                       ######################
###################                                      #######################
####################                                ############################
####################                              ##############################
#####################                             ##############################
########################                         ###############################
#########################                        ###############################
#########################                       ################################
##########################                     #################################
##########################                     #################################
##########################                   ###################################
##########################                  ####################################
################################################################################
################################################################################
TILES

area_snow_village_5 = create_area(:snow_village_5,
                                  'map/snow_village/snow_village_5/SnowFlowerVillage5_0.bmp', 'map/snow_village_5.ogg',
                                  snow_village_5_tiles_text)


area_snow_village_1.gateway = {
    :A => {:area => area_snow_village_2, :direction => Direction::RIGHT}
}

area_snow_village_2.gateway = {
    :B => {:area => area_snow_village_1, :direction => Direction::DOWN},
    :C => {:area => area_snow_village_3, :direction => Direction::UP},
}

area_snow_village_3.gateway = {
    :D => {:area => area_snow_village_2, :direction => Direction::DOWN},
    :E => {:area => area_snow_village_4, :direction => Direction::DOWN},
}

area_snow_village_4.gateway = {
    :F => {:area => area_snow_village_3, :direction => Direction::DOWN},
    :G => {:area => area_snow_village_5, :direction => Direction::DOWN},
}

area_snow_village_5.gateway = {
    :H => {:area => area_snow_village_4, :direction => Direction::RIGHT},
    :I => {:area => area_snow_village_3, :direction => Direction::LEFT},
}

area_snow_village_1.add_visual_element(image_path: 'map/snow_village/snow_village_1/SnowFlowerVillage1_3.bmp',
                                       left: 300, top: 0, y: 361) # 右侧雪人及顶部树叶
area_snow_village_1.add_visual_element(:image_path => 'map/snow_village/snow_village_1/SnowFlowerVillage1_4.bmp',
                                       left: 540, top: 145, y: 361) # 右侧雪人
area_snow_village_1.add_covering(image_path:'map/snow_village/snow_village_1/SnowFlowerVillage1_5.bmp',
                                 x: 0, y: 320) # 左侧雪人

area_snow_village_2.add_visual_element(image_path: 'map/snow_village/snow_village_2/SnowFlowerVillage2_3.bmp',
                                       left: 0, top: 0, y: 250) # 树

area_snow_village_2.add_visual_element(image_path: 'map/snow_village/snow_village_2/SnowFlowerVillage2_4.bmp',
                                       left: 450, top: 90, y: 178) # 蘑菇丛

area_snow_village_2.add_surface(anim: :snow_village_2_rill, x: 540, y: 200) # 小河

area_snow_village_3.add_surface(anim: :snow_village_3_rill, x: 120, y: 150) # 小河

area_snow_village_3.add_visual_element(image_path: 'map/snow_village/snow_village_3/SnowFlowerVillage3_3.bmp',
                                       left: 725, top: 0, y: 363) # 右侧树 上部

area_snow_village_3.add_visual_element(image_path: 'map/snow_village/snow_village_3/SnowFlowerVillage3_4.bmp',
                                       left: 680, top: 180, y: 363) # 右侧树 下部
area_snow_village_3.add_covering(image_path: 'map/snow_village/snow_village_3/SnowFlowerVillage3_5.bmp',
                                 x: 0, y: 400) # 邮箱

area_snow_village_4.add_surface(anim: :snow_village_4_fire, x: 620, y: 140) # 火
area_snow_village_4.add_visual_element(image_path: 'map/snow_village/snow_village_4/SnowFlowerVillage4_3.bmp',
                                       left: 420, top: 100, y: 263) # 沙发
area_snow_village_4.add_visual_element(image_path: 'map/snow_village/snow_village_4/SnowFlowerVillage4_5.bmp',
                                       left: 280, top: 100, y: 198) # 鞋子
area_snow_village_4.add_covering(image_path: 'map/snow_village/snow_village_4/SnowFlowerVillage4_4.bmp',
                                 x: 470, y: 300) # 床

area_snow_village_5.add_covering(image_path: 'map/snow_village/snow_village_5/SnowFlowerVillage5_3.bmp',
                                 x: 0, y: 370) # 左下方图书
area_snow_village_5.add_covering(image_path: 'map/snow_village/snow_village_5/SnowFlowerVillage5_4.bmp',
                                 x: 430, y: 400) # 右下方图书
area_snow_village_5.add_surface(anim: :snow_village_5_left_candle, x: 0, y: 140) # 左侧蜡烛
area_snow_village_5.add_surface(anim: :snow_village_5_right_candle, x: 610, y: 0) # 右侧蜡烛


create_map(:snow_village, '雪花村庄', MapType::VILLAGE,
           [area_snow_village_1, area_snow_village_2, area_snow_village_3, area_snow_village_4, area_snow_village_5])