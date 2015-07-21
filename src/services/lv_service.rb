class LvService
  def image(lv)
    MediaUtil::get_img("lv/lv_#{lv}.gif")
  end
end