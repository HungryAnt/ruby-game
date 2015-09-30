class AntiCheatingService
  def initialize
    @user_id = ''
    @is_cheating = false
  end

  def init_check_cheating_thread
    Thread.new {
      begin
        sleep(1)
        init_client_timestamp
        loop {
          begin
            check_cheating
            sleep(15)
          rescue Exception => e
            puts 'get_messages raise exception:'
            puts e.backtrace.inspect
          end
        }
      rescue Exception => e
        puts 'init_check_cheating_thread raise exception:'
        puts e.backtrace.inspect
      end
    }
  end

  private

  def init_client_timestamp
    params = {
        userId: @user_id,
        timestamp: Time.now.to_i
    }
    http_client = create_http_client
    http_client.path('antiCheating/initClientTimestamp')
    http_client.params(params)
    res = http_client.put
    if res.code != '200'
      throw new RuntimeError("res.code: #{res.code}")
    end
  end

  def check_cheating
    params = {
        userId: @user_id,
        timestamp: Time.now.to_i
    }
    http_client = create_http_client
    http_client.path('antiCheating/initClientTimestamp')
    http_client.params(params)
    res = http_client.put
    if res.code != '200'
      throw new RuntimeError("res.code: #{res.code}")
    end
    is_cheating = res.body != 'false'
    @is_cheating = true if is_cheating
  end

  def create_http_client
    AntHttp::HttpClient.new(NetworkConfig::WEB_SERVICE_ENDPOINT)
  end
end