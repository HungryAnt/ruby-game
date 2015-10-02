class ShoppingService
  def get_vehicles(page_no, page_size)
    params = {
        pageNo: page_no,
        pageSize: page_size
    }

    http_client = HttpClientFactory.create
    http_client.path 'shopping/vehicles'
    http_client.params params
    res = http_client.get

    if res.code == '200'
      map = JSON.parse(res.body)
      PageResult.from_map map
    else
      nil
    end
  end

  def buy(user_id, key)
    params = {
        userId: user_id,
        key: key
    }
    http_client = HttpClientFactory.create
    http_client.path 'shopping/buy'
    http_client.params params
    res = http_client.post
    check_res res
  end

  def apply_gift_vehicle(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'vehicle/gift'
    http_client.params(userId: user_id)
    res = http_client.post
    check_res res
  end

  def convert_to_money(user_id)
    http_client = HttpClientFactory.create
    http_client.path 'rubbish/recycle'
    http_client.params(userId: user_id)
    res = http_client.post
    check_res res
  end

  private
  def check_res(res)
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      raise RuntimeError.new("res.code: #{res.code}")
    end
  end
end