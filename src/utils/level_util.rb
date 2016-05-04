class LevelUtil
  def self.image(lv)
    MediaUtil::get_img("lv/lv_#{lv}.gif")
  end

  def self.pet_lv_image(lv)
    MediaUtil::get_img("pet_lv/PetLevel_#{lv-1}.bmp")
  end
end