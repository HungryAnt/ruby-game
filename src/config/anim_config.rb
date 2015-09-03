def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

lambda {

# def to_role_anim_nums(first_num, last_num)
#   []
# end

  anim_interval = 150

# ================角色动画================

  role_info_list = []
  role_info_list << [RoleType::WAN_GYE, 'WanGye']
  role_info_list << [RoleType::SALARY, 'Salary']
  role_info_list << [RoleType::BANGYE, 'BanGye']
  role_info_list << [RoleType::DOOBU, 'Doobu']
  role_info_list << [RoleType::KIMCHI, 'Kimchi']
  role_info_list << [RoleType::MANL, 'Manl']
  role_info_list << [RoleType::MOO, 'Moo']
  role_info_list << [RoleType::PASERY, 'Pasery']
  role_info_list << [RoleType::PIMENTO, 'Pimento']
  role_info_list << [RoleType::RICE, 'Rice']
  role_info_list << [RoleType::YANGBEA, 'Yangbea']
  role_info_list << [RoleType::YANGPA, 'Yangpa']

  def new_role_anims(prefix, pattern, action, anim_nums_map, anim_interval=150)
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

  role_info_list.each do |role_info|
    role = role_info[0].to_s
    role_pattern = "role/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    role_action_pattern = "role_action/#{role.to_s}/#{role_info[1]}_${num}.bmp"
    prefix = "#{role}_"

    new_role_anims(prefix, role_pattern, 'walk', hor_nums_pair:[30, 34], up_nums_pair:[20, 24], down_nums_pair:[5, 9])
    new_role_anims(prefix, role_pattern, 'stand', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4])
    new_role_anims(prefix, role_pattern, 'run', hor_nums_pair:[50, 54], up_nums_pair:[45, 49], down_nums_pair:[40, 44])
    new_role_anims(prefix, role_pattern, 'eat', hor_nums_pair:[65, 69], up_nums_pair:[60, 64], down_nums_pair:[55, 59])
    new_role_anims(prefix, role_pattern, 'hold_food', hor_nums_pair:[76, 78], up_nums_pair:[73, 75], down_nums_pair:[70, 72])
    new_role_anims(prefix, role_pattern, 'drive', hor_nums_pair:[25, 29], up_nums_pair:[15, 19], down_nums_pair:[0, 4]) # 动画与stand一致
    new_role_anims(prefix, role_action_pattern, 'turn_to_battered', hor_nums_pair:[168, 169], up_nums_pair:[162, 163], down_nums_pair:[156, 157]) # 正被打扁
    new_role_anims(prefix, role_action_pattern, 'battered', hor_nums_pair:[170, 173], up_nums_pair:[164, 167], down_nums_pair:[158, 161]) # 打扁的

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
  end


# ================地面点击动画================
  AnimationManager.new_centered_anim(:area_click) do
    pattern = 'ui/click/CursorShadow_${num}.bmp'
    nums = 0.upto(6)
    [pattern, nums, 120]
  end

# ================鼠标开门动画================

  AnimationManager.new_centered_anim(:goto_area) do
    pattern = 'ui/cursor/CurSor_${num}.bmp'
    nums = [1, 2, 3, 2]
    [pattern, nums, 200]
  end

# ================ map covering ================


# church outside cat
  AnimationManager.new_anim(:church_outside_cat) do
    pattern = 'map/church/outside/cat_${num}.bmp'
    nums = [0, 1, 2, 1]
    images = AnimationUtil.get_images(pattern, nums)
    AnimationUtil.get_animation images, 300
  end

# school ground children
  AnimationManager.new_anim(:school_ground_children) do
    pattern = 'map/school/school_ground/children_${num}.bmp'
    nums = 1.upto(12)
    images = AnimationUtil.get_images(pattern, nums)
    AnimationUtil.get_animation images, 200
  end

# police_policeman
  AnimationManager.new_anim(:police_policeman) do
    pattern = 'map/police/man_${num}.bmp'
    nums = [0, 1, 2, 3, 4, 5, 4, 3, 2, 1]
    images = AnimationUtil.get_images(pattern, nums)
    AnimationUtil.get_animation images, 300
  end

# police_tv
  AnimationManager.new_anim(:police_tv) do
    pattern = 'map/police/tv_${num}.bmp'
    nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1]
    images = AnimationUtil.get_images(pattern, nums)
    AnimationUtil.get_animation images, 200
  end
}.call