# ½ÇÉ«¶¯»­

anim_interval = 150
role_pattern = 'role/wangye/WanGye_#{num}.bmp'

AnimationManager.new_anims do
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

AnimationManager.new_anims do
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

AnimationManager.new_anims do
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

AnimationManager.new_anim(:area_click) do
  pattern = 'ui/click/CursorShadow_#{num}.bmp'
  nums = 0.upto(6)
  [pattern, nums, 200]
end





