class UpdatePetLvMessage
  attr_reader :pet_id, :lv, :exp_in_lv, :max_exp_in_lv

  def initialize(pet_id, lv, exp_in_lv, max_exp_in_lv)
    @pet_id, @lv, @exp_in_lv, @max_exp_in_lv = pet_id, lv, exp_in_lv, max_exp_in_lv
  end

  def to_json(*a)
    {
        type: 'update_pet_lv_message',
        data: {
            pet_id: @pet_id,
            lv: @lv,
            exp_in_lv: @exp_in_lv,
            max_exp_in_lv: @max_exp_in_lv
        }
    }.to_json(*a)
  end

  def self.from_map(map)
    new(map['data']['pet_id'],
        map['data']['lv'].to_i,
        map['data']['exp_in_lv'].to_i,
        map['data']['max_exp_in_lv'].to_i)
  end
end