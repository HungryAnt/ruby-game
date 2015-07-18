class MediaUtil
  def self::init_base_media_path(base_path)
    @@bash_media_path = base_path
  end

  @@image_map = {}
  @@song_map = {}

  def self::get_img(path)
    cache_get_img("#{@@bash_media_path}/img/#{path}")
  end

  def self::get_tileable_img(path)
    Gosu::Image.new("#{@@bash_media_path}/img/#{path}", :tileable => true)
  end

  def self::get_sample(path)
    Gosu::Sample.new("#{@@bash_media_path}/voice/#{path}")
  end

  # def self::get_img_with_transparent_color(path)
  #   img = get_img path
  #   image.clear :dest_select => MagicPink
  # end

  def self::get_song(path)
    cache_get_song "#{@@bash_media_path}/song/#{path}"
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

  def self.cache_get_song(path)
    song = @@song_map[path]
    if song.nil?
      song = Gosu::Song.new(path)
      @@song_map[path] = song
    end
    song
  end
end