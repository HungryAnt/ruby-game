require 'net/http'

class AccountService
  def get_amount(user_id)
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
      res.body.to_i
    else
      0
    end
  end
end