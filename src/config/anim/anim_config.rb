def to_anim_nums(first_num, last_num)
  (first_num..last_num).to_a + (first_num + 1..last_num-1).to_a.reverse
end

def to_simple_anim_nums(first_num, last_num)
  (first_num..last_num).to_a
end

def to_anim_nums_with_options(first_num, last_num, reversed)
  if reversed
    to_anim_nums first_num, last_num
  else
    to_simple_anim_nums first_num, last_num
  end
end

def new_direction_anims(prefix, pattern, action, anim_map = {})
  reversed = true
  reversed = anim_map[:reversed] if anim_map.include?(:reversed)

  hor_nums = to_anim_nums_with_options(*anim_map[:hor_nums_pair], reversed)
  up_nums = to_anim_nums_with_options(*anim_map[:up_nums_pair], reversed)
  down_nums = to_anim_nums_with_options(*anim_map[:down_nums_pair], reversed)
  anim_interval = 150
  anim_interval = anim_map[:anim_interval].to_i if anim_map.include? :anim_interval

  direction_anim_map = {
      "#{action}_left".to_sym => [pattern, hor_nums, anim_interval],
      "#{action}_right".to_sym => [pattern, hor_nums, anim_interval, -1],
      "#{action}_up".to_sym => [pattern, up_nums, anim_interval],
      "#{action}_down".to_sym => [pattern, down_nums, anim_interval]
  }

  if anim_map.include?(:need_down_right_anim) && anim_map[:need_down_right_anim]
    direction_anim_map["#{action}_down_right".to_sym] = [pattern, down_nums, anim_interval, -1]
  end

  AnimationManager.new_centered_anims prefix do
    direction_anim_map
  end
end

def new_direction_anims_with_same_imgs(prefix, pattern, action, raw_img_nums, anim_map = {})
  anim_interval = 150
  anim_interval = anim_map[:anim_interval].to_i if anim_map.include? :anim_interval
  reversed = true
  reversed = anim_map[:reversed] if anim_map.include?(:reversed)
  img_nums = to_anim_nums_with_options(*raw_img_nums, reversed)

  AnimationManager.new_centered_anims prefix do
    {
        "#{action}_left".to_sym => [pattern, img_nums, anim_interval],
        "#{action}_right".to_sym => [pattern, img_nums, anim_interval],
        "#{action}_up".to_sym => [pattern, img_nums, anim_interval],
        "#{action}_down".to_sym => [pattern, img_nums, anim_interval]
    }
  end
end