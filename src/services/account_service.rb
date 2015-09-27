require 'net/http'

class AccountService
  def get_amount(user_id)
    begin
      params = {
          userId: user_id
      }
      uri = URI(NewWorkUtil.get_uri('/account/getAmount', params))
      req = Net::HTTP::Get.new(uri)
      req.content_type = 'application/json'

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end

      if res.code == '200'
        return res.body.to_i
      else
        return 0
      end
    rescue Exception => e
      puts "AccountService.get_amount raise exception: #{e.message}"
      puts e.backtrace.inspect
      return 0
    end
  end
end