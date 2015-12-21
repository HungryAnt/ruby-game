lambda {
  def new_monster_anims(id, options={})
    monster_id = "monster_#{id}"
    prefix = "#{monster_id}_"
    pattern = "monster/#{id}/#{id}_${num}.bmp"

    new_direction_anims prefix, pattern, 'stand',
                        hor_nums_pair:options[:stand_hor],
                        up_nums_pair:options[:stand_up],
                        down_nums_pair:options[:stand_down],
                        anim_interval:250

    new_direction_anims prefix, pattern, 'move',
                        hor_nums_pair:options[:move_hor],
                        up_nums_pair:options[:move_up],
                        down_nums_pair:options[:move_down],
                        need_down_right_anim:true

    new_direction_anims prefix, pattern, 'attack',
                        hor_nums_pair:options[:attack_hor],
                        up_nums_pair:options[:attack_up],
                        down_nums_pair:options[:attack_down],
                        anim_interval:250,
                        reversed:false
  end

  new_monster_anims '0002', stand_down:[0, 3], move_down:[4, 7], attack_down:[9, 12],
                    stand_up:[13, 16], move_up:[17, 21], attack_up:[22, 25],
                    stand_hor:[26, 29], move_hor:[30, 34], attack_hor:[35, 38],
                    capitulate:[39, 40]

  attack_0004 = [9, 12]
  new_monster_anims '0004', stand_down:[0, 3], move_down:[4, 7], attack_down:attack_0004,
                    stand_up:[13, 16], move_up:[17, 20], attack_up:attack_0004,
                    stand_hor:[21, 24], move_hor:[25, 28], attack_hor:attack_0004,
                    capitulate:[29, 30]
}.call