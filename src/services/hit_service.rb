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
        Role::State::HEAD_HIT => get_sound('being_stunned.wav'),
        Monster::State::ATTACK => get_sound('being_stunned.wav'),
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
        when Role::State::FART, Role::State::HEAD_HIT, Monster::State::ATTACK, ShitMine::BOMB
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
        when Role::State::FART, Role::State::HEAD_HIT, Monster::State::ATTACK, ShitMine::BOMB
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
     Role::State::FART, Role::State::HEAD_HIT, Monster::State::ATTACK, ShitMine::BOMB].include? hit_type
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
      when Monster::State::ATTACK
        return 35
      when ShitMine::BOMB
        return 35
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
      when Monster::State::ATTACK
        return 1020
      when ShitMine::BOMB
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
      when Monster::State::ATTACK
        return 1700
      when ShitMine::BOMB
        return 2000
    end
  end

  def in_hit_range?(hit_type, x0, y0, x1, y1)
    raise_error(hit_type) unless is_hit? hit_type
    case hit_type
      when Monster::State::ATTACK
        return GraphicsUtil.pt_in_ellipse? x0, y0, x1, y1, 175, 100
      when ShitMine::BOMB
        return Gosu::distance(x0, y0, x1, y1) < 60
      else
        return Gosu::distance(x0, y0, x1, y1) < 28
    end
  end

  private
  def get_sound(sound_path)
    MediaUtil::get_sample(sound_path)
  end

  def raise_error(hit_type)
    raise ArgumentError.new "Error hit_type: #{hit_type}"
  end
end