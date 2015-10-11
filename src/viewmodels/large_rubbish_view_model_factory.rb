class LargeRubbishViewModelFactory
  def self.create_large_rubbish_vm(item_map)
    id, x, y = item_map['id'], item_map['x'].to_i, item_map['y'].to_i
    large_rubbish_type_id = item_map['large_rubbish_type_id'].to_i
    max_hp, hp = item_map['max_hp'].to_f, item_map['hp'].to_f
    large_rubbish = LargeRubbish.new(id, x, y, large_rubbish_type_id, max_hp, hp)
    large_rubbish_vm = LargeRubbishViewModel.new large_rubbish
    large_rubbish_vm
  end
end