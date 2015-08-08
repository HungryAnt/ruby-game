class SongService
  def play_song(path)
    current_song = Gosu::Song::current_song
    current_song.stop unless current_song.nil?

    song = MediaUtil::get_song(path)
    song.play(true)
  end
end