class UserEquipmentService
  def initialize
    autowired(PlayerService)
  end

  def update
    http_client = HttpClientFactory.create
    http_client.path 'vehicle/getVehicles'
    http_client.params(userId: @player_service.user_id)
    res = http_client.get
    if res.code != '200'
      puts "res.code: #{res.code} res.body: #{res.body}"
      raise RuntimeError.new("res.code: #{res.code}")
    end
    vehicles = JSON.parse(res.body)
    @player_service.update_vehicles(vehicles)
  end
end