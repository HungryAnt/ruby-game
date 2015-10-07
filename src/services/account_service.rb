require 'net/http'

class AccountService
  def get_amount(user_id)
    begin
      http_client = HttpClientFactory.create
      http_client.path 'account/getAmount'
      http_client.params(userId: user_id)
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
end