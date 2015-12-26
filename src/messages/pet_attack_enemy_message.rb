class PetAttackEnemyMessage
  attr_reader :pet_id, :user_id, :area_id, :enemy_type, :enemy_id

  def initialize(pet_id, user_id, area_id, enemy_type, enemy_id)
    @pet_id, @user_id, @area_id = pet_id, user_id, area_id
    @enemy_type, @enemy_id = enemy_type, enemy_id
  end

  def to_json(*a)
    {
        type: 'pet_attack_enemy_message',
        data: {
            pet_id: @pet_id,
            user_id: @user_id,
            area_id: @area_id,
            enemy_type: @enemy_type,
            enemy_id: @enemy_id
        }
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['pet_id'],
        map['data']['user_id'],
        map['data']['area_id'],
        map['data']['enemy_type'],
        map['data']['enemy_id'])
  end
end