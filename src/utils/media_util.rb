class MediaUtil
  def self::get_img(path)
    Gosu::Image.new('media/img/' + path)
  end

  def self::get_tileable_img(path)
    Gosu::Image.new('media/img/' + path, :tileable => true)
  end

  def self::get_sample(path)
    Gosu::Sample.new('media/voice/' + path)
  end
end