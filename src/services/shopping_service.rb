class ShoppingService
  def get_vehicles(page_no, page_size)
    params = {
        pageNo: page_no,
        pageSize: page_size
    }

    http_client = create_http_client
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

  private
  def create_http_client
    AntHttp::HttpClient.new(NetworkConfig::WEB_SERVICE_ENDPOINT)
  end
end