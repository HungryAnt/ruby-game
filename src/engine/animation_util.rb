module AnimationUtil
  def self.get_centered_animation(path_pattern, nums, interval, scale_x = 1, scale_y = 1, offset=[0, 0])
    images = get_centered_images path_pattern, nums, scale_x, scale_y
    Animation.new(images, interval, offset)
  end

  def self.get_animation(images, interval)
    Animation.new(images, interval)
  end

  def self.get_images(path_pattern, nums)
    images = []
    nums.each do |num|
      images << Image.new(get_img(path_pattern, num))
    end
    images
  end

  private
  def self.get_centered_images(path_pattern, nums, scale_x = 1, scale_y = 1)
    images = []
    nums.each do |num|
      images << CenteredImage.new(get_img(path_pattern, num), scale_x, scale_y)
    end
    images
  end

  def self.get_img(path_pattern, num)
    path = get_path path_pattern, num
    MediaUtil::get_img(path)
  end

  def self.get_path(path_pattern, num)
    path_pattern.gsub /\$\{num\}/, num.to_s
  end
end