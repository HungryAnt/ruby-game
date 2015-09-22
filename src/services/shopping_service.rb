class ShoppingService
  def get_vehicles(page_no, page_size)
    params = {
        pageNo: page_no,
        pageSize: page_size
    }
    uri = URI(NewWorkUtil.get_uri('/shopping/vehicles', params))
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