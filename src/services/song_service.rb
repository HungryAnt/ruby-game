class SongService
  def initialize
    @curren_song_path = nil
  end

  def play_song(path)
    return if path == @curren_song_path
    @curren_song_path = path
    stop_song
    song = MediaUtil::get_song(path)
    song.play(true)
  end

  def stop_song
    current_song = Gosu::Song::current_song
    current_song.stop unless current_song.nil?
  end
end