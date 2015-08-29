# ================ car 828 ================

def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

# AnimationManager.new_centered_anims prefix do
#   pattern = 'car/828/828_${num}.bmp'
#   hor_nums = to_anim_nums(32, 47)
#   up_nums = to_anim_nums(16, 31)
#   down_nums = to_anim_nums(0,15)
#   {
#       :car_828_left => [pattern, hor_nums, anim_interval],
#       :car_828_right => [pattern, hor_nums, anim_interval, -1],
#       :car_828_up => [pattern, up_nums, anim_interval],
#       :car_828_down => [pattern, down_nums, anim_interval]
#   }
# end

# AnimationManager.new_centered_anims prefix do
#   pattern = 'car/604/604_${num}.bmp'
#   hor_nums = to_anim_nums(16, 23)
#   up_nums = to_anim_nums(8, 15)
#   down_nums = to_anim_nums(0,7)
#   {
#       :car_604_left => [pattern, hor_nums, anim_interval],
#       :car_604_right => [pattern, hor_nums, anim_interval, -1],
#       :car_604_up => [pattern, up_nums, anim_interval],
#       :car_604_down => [pattern, down_nums, anim_interval]
#   }
# end

def create_car_anims(car_id, anim_nums_map)
  anim_interval = 150
  AnimationManager.new_centered_anims '' do
    pattern = "car/#{car_id}/#{car_id}_${num}.bmp"
    hor_nums = to_anim_nums(*anim_nums_map[:hor_nums_pair])
    up_nums = to_anim_nums(*anim_nums_map[:up_nums_pair])
    down_nums = to_anim_nums(*anim_nums_map[:down_nums_pair])
    {
        "car_#{car_id}_left".to_sym => [pattern, hor_nums, anim_interval],
        "car_#{car_id}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
        "car_#{car_id}_up".to_sym => [pattern, up_nums, anim_interval],
        "car_#{car_id}_down".to_sym => [pattern, down_nums, anim_interval]
    }
  end
end

create_car_anims(604, hor_nums_pair:[16, 23], up_nums_pair:[8, 15], down_nums_pair:[0, 7])
create_car_anims(828, hor_nums_pair:[32, 47], up_nums_pair:[16, 31], down_nums_pair:[0,15])
create_car_anims(39, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0,1])
create_car_anims(40, hor_nums_pair:[4, 5], up_nums_pair:[2, 3], down_nums_pair:[0,1])
