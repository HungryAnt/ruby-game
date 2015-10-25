class HitService
  def initialize
    @hit_sound_map = {
        Role::State::HIT => get_sound('hit.wav'),
        # Role::State::FINGER_HIT => get_sound('common_attack.wav'),
        Role::State::FART => get_sound('fart.wav'),
        # Role::State::HEAD_HIT => get_sound('common_attack.wav')
    }
    @battered_sound_map = {
        Role::State::HIT => get_sound('being_battered.wav'),
        Role::State::FINGER_HIT => get_sound('being_stunned.wav'),
        Role::State::FART => get_sound('fart.wav'),
        Role::State::HEAD_HIT => get_sound('being_stunned.wav')
    }
  end

  def get_hitting_state(hit_type)
    if is_hit? hit_type
      hit_type
    else
      raise_error hit_type
    end
  end

  def get_turn_to_battered_state(hit_type)
    if is_hit? hit_type
      case hit_type
        when Role::State::HIT
          return Role::State::TURN_TO_BATTERED
        when Role::State::FINGER_HIT
          return Role::State::TURN_TO_FINGER_BATTERED
        when Role::State::FART, Role::State::HEAD_HIT
          return Role::State::TURN_TO_STUNNED
      end
    end
    raise_error hit_type
  end

  def get_battered_state(hit_type)
    if is_hit? hit_type
      case hit_type
        when Role::State::HIT
          return Role::State::BATTERED
        when Role::State::FINGER_HIT
          return Role::State::FINGER_BATTERED
        when Role::State::FART, Role::State::HEAD_HIT
          return Role::State::STUNNED
      end
    end
    raise_error hit_type
  end

  def play_hitting_sound(hit_type)
    if is_hit? hit_type
      if @hit_sound_map.include? hit_type
        @hit_sound_map[hit_type].play
      end
    end
  end

  def play_battered_sound(hit_type)
    if is_hit? hit_type
      if @battered_sound_map.include? hit_type
        @battered_sound_map[hit_type].play
      end
    end
  end

  def is_hit?(hit_type)
    [Role::State::HIT, Role::State::FINGER_HIT,
     Role::State::FART, Role::State::HEAD_HIT].include? hit_type
  end

  def get_battered_cost_hp(hit_type)
    return unless is_hit? hit_type
    case hit_type
      when Role::State::HIT
        return 45
      when Role::State::FINGER_HIT
        return 25
      when Role::State::FART
        return 25
      when Role::State::HEAD_HIT
        return 25
    end
  end

  def get_turn_to_battered_duration_time(hit_type)
    raise_error(hit_type) unless is_hit? hit_type
    case hit_type
      when Role::State::HIT
        return 270
      when Role::State::FINGER_HIT
        return 720
      when Role::State::FART
        return 1020
      when Role::State::HEAD_HIT
        return 1020
    end
  end

  def get_battered_duration_time(hit_type)
    raise_error(hit_type) unless is_hit? hit_type
    case hit_type
      when Role::State::HIT
        return 6000
      when Role::State::FINGER_HIT
        return 2000
      when Role::State::FART
        return 1700
      when Role::State::HEAD_HIT
        return 1700
    end
  end

  def cannot_move?(hit_type)
    [Role::State::FINGER_HIT, Role::State::FART, Role::State::HEAD_HIT].include? hit_type
  end

  private
  def get_sound(sound_path)
    MediaUtil::get_sample(sound_path)
  end

  def raise_error(hit_type)
    raise ArgumentError.new "Error hit_type: #{hit_type}"
  end
end