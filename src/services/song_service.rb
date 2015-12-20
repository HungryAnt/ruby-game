class SongService
  def initialize
    @current_song_path = nil
    @is_music_on = true
  end

  def play_song(path)
    return if path == @current_song_path
    @current_song_path = path
    stop_song
    song = MediaUtil::get_song(path)
    song.play(true)
    song.pause unless @is_music_on
  end

  def stop_song
    current_song = Gosu::Song::current_song
    current_song.stop unless current_song.nil?
  end

  def turn_on
    @is_music_on = true
    current_song = Gosu::Song::current_song
    current_song.play(true) unless current_song.nil?
  end

  def turn_off
    @is_music_on = false
    current_song = Gosu::Song::current_song
    current_song.pause unless current_song.nil?
  end
end