module AnimationUtil
  def self.get_animation(path_pattern, nums,
      interval, scale_x = 1, scale_y = 1)
    images = []
    nums.each do |num|
      images << get_img(path_pattern, num)
    end
    Animation.new(images, interval, scale_x, scale_y)
  end

  def self.get_img(path_pattern, num)
    path = get_path path_pattern, num
    MediaUtil::get_img(path)
  end

  def self.get_path(path_pattern, num)
    path_pattern.gsub /#\{num\}/, num.to_s
  end
end