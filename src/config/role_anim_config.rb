lambda {
  anim_interval = 150

  # ================角色动画================

  role_info_list = []
  role_info_list << [RoleType::WAN_GYE, 'WanGye']
  role_info_list << [RoleType::SALARY, 'Salary', :img249] # 标记有img249的图片都多了一张210图片
  role_info_list << [RoleType::BANGYE, 'BanGye']
  role_info_list << [RoleType::DOOBU, 'Doobu']
  role_info_list << [RoleType::KIMCHI, 'Kimchi']
  role_info_list << [RoleType::MANL, 'Manl', :img249]
  role_info_list << [RoleType::MOO, 'Moo', :img249]
  role_info_list << [RoleType::PASERY, 'Pasery', :img249]
  role_info_list << [RoleType::PIMENTO, 'Pimento']
  role_info_list << [RoleType::RICE, 'Rice']
  role_info_list << [RoleType::YANGBEA, 'Yangbea', :img249]
  role_info_list << [RoleType::YANGPA, 'Yangpa']

  def new_role_anims(prefix, pattern, action, anim_nums_map)
    anim_interval = 150
    AnimationManager.new_centered_anims prefix do
      hor_nums = to_anim_nums(*anim_nums_map[:hor_nums_pair])
      up_nums = to_anim_nums(*anim_nums_map[:up_nums_pair])
      down_nums = to_anim_nums(*anim_nums_map[:down_nums_pair])
      {
          "#{action}_left".to_sym => [pattern, hor_nums, anim_interval],
          "#{action}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
          "#{action}_up".to_sym => [pattern, up_nums, anim_interval],
          "#{action}_down".to_sym => [pattern, down_nums, anim_interval]
      }
    end
  end

  def new_role_anims_with_same_imgs(prefix, pattern, action, raw_img_nums, anim_interval=150, reversed=true)
    AnimationManager.new_centered_anims prefix do
      if reversed
        img_nums = to_anim_nums(*raw_img_nums)
      else
        img_nums = to_simple_anim_nums(*raw_img_nums)
      end
      {
          "#{action}_left".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_right".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_up".to_sym => [pattern, img_nums, anim_interval],
          "#{action}_down".to_sym => [pattern, img_nums, anim_interval]
      }
    end
  end

  role_info_list.each do |role_info|
    role = role_info[0].to_s
    role_pattern = "role/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    role_action_pattern = "role_action/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    prefix = "#{role}_"
    img249 = role_info[2] == :img249

    new_role_anims(prefix, role_pattern, 'walk', hor_nums_pair:[30, 34], up_nums_pair:[20, 24], down_nums_pair:[5, 9])
    new_role_anims(prefix, role_pattern, 'stand', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4])
    new_role_anims(prefix, role_pattern, 'run', hor_nums_pair:[50, 54], up_nums_pair:[45, 49], down_nums_pair:[40, 44])
    new_role_anims(prefix, role_pattern, 'eat', hor_nums_pair:[65, 69], up_nums_pair:[60, 64], down_nums_pair:[55, 59])
    new_role_anims(prefix, role_pattern, 'hold_food', hor_nums_pair:[76, 78], up_nums_pair:[73, 75], down_nums_pair:[70, 72])
    new_role_anims(prefix, role_pattern, 'drive', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4]) # 动画与stand一致
    new_role_anims(prefix, role_action_pattern, 'turn_to_battered', hor_nums_pair:[168, 169], up_nums_pair:[162, 163], down_nums_pair:[156, 157]) # 正被打扁
    new_role_anims(prefix, role_action_pattern, 'battered', hor_nums_pair:[170, 173], up_nums_pair:[164, 167], down_nums_pair:[158, 161]) # 打扁的

    new_role_anims(prefix, role_action_pattern, 'scare', hor_nums_pair:[10, 14], up_nums_pair:[5, 9], down_nums_pair:[0, 4]) # 惊吓
    new_role_anims(prefix, role_action_pattern, 'lecherous', hor_nums_pair:[25, 29], up_nums_pair:[20, 24], down_nums_pair:[15, 19]) # 好色
    new_role_anims(prefix, role_action_pattern, 'bye', hor_nums_pair:[40, 44], up_nums_pair:[35, 39], down_nums_pair:[30, 34])
    new_role_anims(prefix, role_action_pattern, 'cry', hor_nums_pair:[55, 59], up_nums_pair:[50, 54], down_nums_pair:[45, 49])
    new_role_anims(prefix, role_action_pattern, 'laugh', hor_nums_pair:[70, 74], up_nums_pair:[65, 69], down_nums_pair:[60, 63])
    new_role_anims(prefix, role_action_pattern, 'finger_hit', hor_nums_pair:[85, 89], up_nums_pair:[80, 84], down_nums_pair:[75, 79])
    new_role_anims(prefix, role_action_pattern, 'turn_to_finger_battered', hor_nums_pair:[104, 108], up_nums_pair:[97, 101], down_nums_pair:[90, 94])
    new_role_anims(prefix, role_action_pattern, 'finger_battered', hor_nums_pair:[109, 110], up_nums_pair:[102, 103], down_nums_pair:[95, 96])
    new_role_anims(prefix, role_action_pattern, 'fart', hor_nums_pair:[121, 125], up_nums_pair:[116, 120], down_nums_pair:[111, 115])
    new_role_anims(prefix, role_action_pattern, 'head_hit', hor_nums_pair:[136, 140], up_nums_pair:[131, 135], down_nums_pair:[126, 130])
    new_role_anims(prefix, role_action_pattern, 'turn_to_stunned', hor_nums_pair:[188, 194], up_nums_pair:[181, 187], down_nums_pair:[174, 180]) # 正被击晕

    new_role_anims_with_same_imgs(prefix, role_action_pattern, 'stunned', [195, 202]) # 晕了


    arrogant_anim_interval = 250
    worry_anim_interval = 250
    happy_anim_interval = 250
    roll_anim_interval = 200
    sleep_anim_interval = 350
    if img249
      # 投掷（魔法球）
      new_role_anims(prefix, role_action_pattern, 'cast', hor_nums_pair:[216, 220], up_nums_pair:[211, 215], down_nums_pair:[205, 209])
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'arrogant', [221, 225], arrogant_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'worry', [226, 230], worry_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'happy', [231, 235], happy_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'roll', [236, 244], roll_anim_interval, false)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'sleep', [245, 249], sleep_anim_interval)
    else
      new_role_anims(prefix, role_action_pattern, 'cast', hor_nums_pair:[215, 219], up_nums_pair:[210, 214], down_nums_pair:[205, 209])
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'arrogant', [220, 224], arrogant_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'worry', [225, 229], worry_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'happy', [230, 234], happy_anim_interval)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'roll', [235, 243], roll_anim_interval, false)
      new_role_anims_with_same_imgs(prefix, role_action_pattern, 'sleep', [244, 248], sleep_anim_interval)
    end

    AnimationManager.new_centered_anims prefix do
      h_nums = [151, 152, 153, 154]
      up_nums = [147, 148, 149, 150]
      down_nums = [141, 142, 143, 144]
      {
          :hit_left => [role_action_pattern, h_nums, anim_interval, 1, 1, [-27, -13]],
          :hit_right => [role_action_pattern, h_nums, anim_interval, -1, 1, [27, -13]],
          :hit_up => [role_action_pattern, up_nums, anim_interval],
          :hit_down => [role_action_pattern, down_nums, anim_interval]
      }
    end

    AnimationManager.new_centered_anims prefix do
      h_nums = [85, 86, 87]
      up_nums = [82, 83, 84]
      down_nums = [79, 80, 81]
      {
          :collecting_rubbish_left => [role_pattern, h_nums, anim_interval, 1, 1, [8, 0]],
          :collecting_rubbish_right => [role_pattern, h_nums, anim_interval, -1, 1, [-8, 0]],
          :collecting_rubbish_up => [role_pattern, up_nums, anim_interval],
          :collecting_rubbish_down => [role_pattern, down_nums, anim_interval]
      }
    end
  end
}.call