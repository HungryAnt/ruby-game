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
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###                                                           ##################
###     X                                                     ##################
###                                                           ##################
###                                                           ##################
################################################################################
TILES

area = create_area(:police, 'map/police/police.png', nil, tiles_text)

# �����ڸ���
area.add_covering(:anim => :police_policeman, :x => 608, :y => 239)
area.add_covering(:anim => :police_tv, :x => 700, :y => 20)

create_map(:police, [area])