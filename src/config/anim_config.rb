anim_interval = 150

# ================角色动画================

role_info_list = []
role_info_list << [RoleType::WAN_GYE, 'WanGye']
role_info_list << [RoleType::SALARY, 'Salary']

role_info_list.each do |role_info|
  role = role_info[0].to_s
  role_pattern = "role/#{role.to_s}/#{role_info[1]}_${num}.bmp"
  prefix = "#{role}_"

  AnimationManager.new_centered_anims prefix do
    h_nums = [32, 31, 30, 31, 32, 33, 34, 33]
    up_nums = [22, 21, 20, 21, 22, 23, 24, 23]
    down_nums = [7, 6, 5, 6, 7, 8, 9, 8]
    {
        :walk_left => [role_pattern, h_nums, anim_interval],
        :walk_right => [role_pattern, h_nums, anim_interval, -1],
        :walk_up => [role_pattern, up_nums, anim_interval],
        :walk_down => [role_pattern, down_nums, anim_interval]
    }
  end

  AnimationManager.new_centered_anims prefix do
    h_nums = [27, 26, 25, 26, 27, 28, 29, 28]
    up_nums = [17, 16, 15, 16, 17, 18, 19, 18]
    down_nums = [2, 1, 0, 1, 2, 3, 4, 3]
    {
        :stand_left => [role_pattern, h_nums, anim_interval],
        :stand_right => [role_pattern, h_nums, anim_interval, -1],
        :stand_up => [role_pattern, up_nums, anim_interval],
        :stand_down => [role_pattern, down_nums, anim_interval]
    }
  end

  AnimationManager.new_centered_anims prefix do
    h_nums = [52, 51, 50, 51, 52, 53, 54, 53]
    up_nums = [47, 46, 45, 46, 47, 48, 49, 48]
    down_nums = [42, 41, 40, 41, 42, 43, 44, 43]
    {
        :run_left => [role_pattern, h_nums, anim_interval],
        :run_right => [role_pattern, h_nums, anim_interval, -1],
        :run_up => [role_pattern, up_nums, anim_interval],
        :run_down => [role_pattern, down_nums, anim_interval]
    }
  end

  AnimationManager.new_centered_anims prefix do
    h_nums = [67, 66, 65, 66, 67, 68, 69, 68]
    up_nums = [62, 61, 60, 61, 62, 63, 64, 63]
    down_nums = [57, 56, 55, 56, 57, 58, 59, 58]
    {
        :eat_left => [role_pattern, h_nums, anim_interval],
        :eat_right => [role_pattern, h_nums, anim_interval, -1],
        :eat_up => [role_pattern, up_nums, anim_interval],
        :eat_down => [role_pattern, down_nums, anim_interval]
    }
  end

  AnimationManager.new_centered_anims prefix do
    h_nums = [77, 76, 77, 78]
    up_nums = [74, 73, 74, 75]
    down_nums = [71, 70, 71, 72]
    {
        :hold_food_left => [role_pattern, h_nums, anim_interval],
        :hold_food_right => [role_pattern, h_nums, anim_interval, -1],
        :hold_food_up => [role_pattern, up_nums, anim_interval],
        :hold_food_down => [role_pattern, down_nums, anim_interval]
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