class MediaUtil
  BASH_MEDIA_PATH = '../media'

  @@image_map = {}

  def self::get_img(path)
    cache_get_img("#{BASH_MEDIA_PATH}/img/#{path}")
  end

  def self::get_tileable_img(path)
    Gosu::Image.new("#{BASH_MEDIA_PATH}/img/#{path}", :tileable => true)
  end

  def self::get_sample(path)
    Gosu::Sample.new("#{BASH_MEDIA_PATH}/voice/#{path}")
  end

  # def self::get_img_with_transparent_color(path)
  #   img = get_img path
  #   image.clear :dest_select => MagicPink
  # end

  def self::get_song(path)
    Gosu::Song.new("#{BASH_MEDIA_PATH}/song/#{path}")
  end

  private
  def self.cache_get_img(path)
    img = @@image_map[path]
    if img.nil?
      img = Gosu::Image.new(path)
      @@image_map[path] = img
    end
    img
  end
end