class DotaService

  def initialize
    @voice_names = %w(first_blood double_kill dominating mega_kill ultra_kill unstoppable whicked_sick godlike holy_shit)
    @score = 0
  end

  def kill
    play
    @score = [@score + 1, @voice_names.size - 1].min
  end

  def die
    @score = 0
  end

  def play
    voice_name = @voice_names[@score]
    voice_path = "dota/#{voice_name}.wav"
    MediaUtil.get_sample(voice_path).play
  end
end