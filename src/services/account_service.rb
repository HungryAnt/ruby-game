require 'net/http'

class AccountService
  def get_amount(user_id)
    params = {
        userId: user_id
    }
    uri = URI(NewWorkUtil.get_uri('/account/getAmount', params))
    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'

    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end

    if res.code == 200
      res.body
    else
      0
    end
  end
end