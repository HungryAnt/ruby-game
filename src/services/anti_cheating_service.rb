class AntiCheatingService
  def initialize(user_id)
    @user_id = user_id
    @cheating_call_back = nil
  end

  def on_cheating(&cheating_call_back)
    @cheating_call_back = cheating_call_back
  end

  def call_cheating
    @cheating_call_back.call unless @cheating_call_back.nil?
  end

  def init_check_cheating_thread
    Thread.new {
      begin
        sleep(1)
        init_client_timestamp
        loop {
          begin
            check_cheating
          rescue Exception => e
            puts "check_cheating raise exception:#{e.message}"
            puts e.backtrace.inspect
          end
          sleep(15)
        }
      rescue Exception => e
        puts "init_check_cheating_thread raise exception:#{e.message}"
        puts e.backtrace.inspect
      end
    }
  end

  private

  def init_client_timestamp
    init_base_timestamp

    params = {
        userId: @user_id,
        timestamp: current_timestamp
    }
    http_client = HttpClientFactory.create
    http_client.path('antiCheating/initClientTimestamp')
    http_client.params(params)
    res = http_client.put
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      raise RuntimeError.new("res.code: #{res.code}")
    end
  end

  def check_cheating
    params = {
        userId: @user_id,
        timestamp: current_timestamp
    }
    http_client = HttpClientFactory.create
    http_client.path('antiCheating/checkCheating')
    http_client.params(params)
    res = http_client.put
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      throw new RuntimeError("res.code: #{res.code}")
    end
    is_cheating = res.body != 'false'
    call_cheating if is_cheating
  end

  def init_base_timestamp
    @base_timestamp = Time.now.to_i - Gosu::milliseconds / 1000
  end

  def current_timestamp
    @base_timestamp + Gosu::milliseconds / 1000
  end
end