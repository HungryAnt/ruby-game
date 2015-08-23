anim_interval = 150

# ================ car 828 ================

def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

prefix = ''

AnimationManager.new_centered_anims prefix do
  pattern = 'car/828/828_${num}.bmp'
  hor_nums = to_anim_nums(32, 47)
  up_nums = to_anim_nums(16, 31)
  down_nums = to_anim_nums(0,15)
  {
      :car_828_left => [pattern, hor_nums, anim_interval],
      :car_828_right => [pattern, hor_nums, anim_interval, -1],
      :car_828_up => [pattern, up_nums, anim_interval],
      :car_828_down => [pattern, down_nums, anim_interval]
  }
end