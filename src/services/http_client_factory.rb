class HttpClientFactory
  def self.create
    AntHttp::HttpClient.new(NetworkConfig::WEB_SERVICE_ENDPOINT)
  end
end