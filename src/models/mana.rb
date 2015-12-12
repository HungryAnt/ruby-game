module Mana
  attr_reader :mana

  MAX_MANA = 100

  def init_mana
    @mana = 100
  end

  private :init_mana

  def inc_mana(value)
    @mana = [@mana+value, MAX_MANA].min
  end

  def dec_mana(value)
    @mana = [@mana-value, 0].max
  end
end