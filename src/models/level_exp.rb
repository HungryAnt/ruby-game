module LevelExp
  attr_accessor :lv, :exp_in_lv, :max_exp_in_lv

  def update_lv_exp(lv, exp_in_lv, max_exp_in_lv)
    @lv, @exp_in_lv, @max_exp_in_lv = lv, exp_in_lv, max_exp_in_lv
  end

  private

  alias :init_level_exp :update_lv_exp

  # def init_level_exp(lv, exp_in_lv, max_exp_in_lv)
  #   update_lv_exp lv, exp_in_lv, max_exp_in_lv
  # end
end