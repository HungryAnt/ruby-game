class ShoppingService
  def initialize
    @page_result_map = {}
  end

  def get_goods(goods_type, page_no, page_size)
    cache_key = "#{goods_type.to_s}__#{page_no}"
    page_result = @page_result_map[cache_key]
    return page_result unless page_result.nil?
    page_result = get_goods_actually goods_type, page_no, page_size
    @page_result_map[cache_key] = page_result unless page_result.nil?
    page_result
  end

  def buy(user_id, key)
    http_client = HttpClientFactory.create
    http_client.path 'shopping/buy'
    http_client.params userId: user_id, key: key
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

  def get_goods_actually(goods_type, page_no, page_size)
    camel_cash_equip_type = StringUtil.underline_to_camel goods_type.to_s
    http_client = HttpClientFactory.create
    http_client.path 'shopping/goods'
    http_client.params equipmentType: camel_cash_equip_type, pageNo: page_no, pageSize: page_size
    res = http_client.get

    if res.code == '200'
      map = JSON.parse(res.body)
      PageResult.from_map map
    else
      nil
    end
  end

  def check_res(res)
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      raise RuntimeError.new("res.code: #{res.code}")
    end
  end
end