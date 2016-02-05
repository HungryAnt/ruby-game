module HitTypeDefinition
  def self.cannot_move?(hit_type)
    [Role::State::FINGER_HIT, Role::State::FART, Role::State::HEAD_HIT, Monster::State::ATTACK,
     ShitMine::BOMB].include? hit_type
  end
end