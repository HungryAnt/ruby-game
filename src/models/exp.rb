module Exp
  attr_reader :lv, :exp, :max_exp

  def initialize
    @lv = 1
    @exp = 0
    @max_exp = lv_max_exp
  end

  def lv_max_exp
    @lv * 100
  end

  def inc_exp(value)
    exp = @exp + value
    while exp > @max_exp do
      exp -= @max_exp
      @lv += 1
      @max_exp = lv_max_exp
    end
    @exp = exp
  end
end