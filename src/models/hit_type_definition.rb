module HitTypeDefinition
  def self.cannot_move?(hit_type)
    [Role::State::FINGER_HIT, Role::State::FART, Role::State::HEAD_HIT].include? hit_type
  end
end