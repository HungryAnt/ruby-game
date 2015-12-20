class MonsterViewModelFactory
  def self.create_monster_vm(item_map)
    id, x, y = item_map['id'], item_map['x'].to_i, item_map['y'].to_i
    monster_type_id = item_map['monster_type_id']
    max_hp, hp = item_map['max_hp'].to_f, item_map['hp'].to_f
    monster = Monster.new(id, monster_type_id, max_hp, hp, x, y)
    monster_vm = MonsterViewModel.new monster
    monster_vm
  end
end