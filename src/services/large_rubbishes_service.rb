class LargeRubbishesService
  def initialize
    @large_rubbish_msg_callback = nil
  end

  def register_large_rubbish_msg_callback(&callback)
    @large_rubbish_msg_callback = callback
  end

  def add_large_rubbish_msg(large_rubbish_msg)
    @large_rubbish_msg_callback.call large_rubbish_msg
  end
end