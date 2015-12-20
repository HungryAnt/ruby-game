class MusicSample
  @@is_music_on = true

  def initialize(sample)
    @sample = sample
  end

  def self.turn_on
    @@is_music_on = true
  end

  def self.turn_off
    @@is_music_on = false
  end

  def play(*args)
    return unless @@is_music_on
    @sample.play *args
  end

  def play_pan(*args)
    return unless @@is_music_on
    @sample.play_pan *args
  end

  def method_missing(method, *args)
    @sample.send method, *args
  end
end