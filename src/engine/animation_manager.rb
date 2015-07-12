class AnimationManager
  @@anim_dict = {}

  def self::new_anim(key)
    return unless block_given?
    anim = AnimationUtil::get_animation(*yield)
    add_anim(key, anim)
  end

  def self::new_anims()
    return unless block_given?
    dict = yield
    dict.each_pair do |k, v|
      add_anim k, AnimationUtil::get_animation(*v)
    end
  end

  def self::add_anim(key, anim)
    @@anim_dict[key] = anim
  end

  def self::get_anim(key)
    @@anim_dict[key]
  end

  # def self::[]=(key, anim)
  #   add_anim(key, anim)
  # end
  #
  # def self::[](key)
  #   get_anim(key)
  # end
end