class AnimationManager
  @@anim_dict = {}

  def self::new_centered_anim(key)
    return unless block_given?
    anim = AnimationUtil::get_centered_animation(*yield)
    add_anim key, anim
  end

  def self::new_centered_anims(prefix)
    return unless block_given?
    dict = yield
    dict.each_pair do |k, v|
      anim = AnimationUtil::get_centered_animation(*v)
      add_anim((prefix + k.to_s).to_sym, anim)
    end
  end

  # 更自由的接口
  def self::new_anim(key)
    return unless block_given?
    anim = yield
    add_anim key, anim
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