require 'net/http'

class AccountService
  def get_amount(user_id)
    begin
      params = {
          userId: user_id
      }
      http_client = create_http_client
      http_client.path 'account/getAmount'
      http_client.params params
      res = http_client.get

      if res.code == '200'
        return res.body.to_i
      else
        return 0
      end
    rescue Exception => e
      puts 'AccountService.get_amount raise exception'
      puts e.backtrace.inspect
      return 0
    end
  end

  def create_http_client
    AntHttp::HttpClient.new(NetworkConfig::WEB_SERVICE_ENDPOINT)
  end
end