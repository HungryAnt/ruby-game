module Hp
  attr_reader :hp, :max_hp

  def init_hp
    @hp = 100
    @max_hp = 100
  end

  private :init_hp

  def inc_hp(value)
    @hp = [@hp+value, @max_hp].min
  end

  def dec_hp(value)
    @hp = [@hp-value, 0].max
  end
end