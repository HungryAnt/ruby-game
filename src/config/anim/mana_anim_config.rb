lambda {
  new_anim = lambda do |key, pattern, first_num, last_num|
    AnimationManager.new_anim(key.to_sym) do
      nums = [*(first_num..last_num)]
      images = AnimationUtil.get_images(pattern, nums)
      AnimationUtil.get_animation images, 150
    end
  end

  pattern = 'ui/mana/Mana_${num}.bmp'

  new_anim.call 'mana_0', pattern, 0, 0
  new_anim.call 'mana_1', pattern, 1, 3
  new_anim.call 'mana_2', pattern, 4, 6
  new_anim.call 'mana_3', pattern, 7, 9
  new_anim.call 'mana_4', pattern, 10, 12
  new_anim.call 'mana_5', pattern, 13, 15
  new_anim.call 'mana_6', pattern, 16, 18
  new_anim.call 'mana_7', pattern, 19, 21
  new_anim.call 'mana_8', pattern, 22, 24
  new_anim.call 'mana_9', pattern, 25, 27
}.call