class NewWorkUtil
  def self.get_uri(path, params={})
    uri = "#{NetworkConfig::WEB_SERVICE_ENDPOINT}#{path}"
    if params.size > 0
      uri += '?'
      index = 0
      params.each_pair do |k, v|
        uri += "#{k.to_s}=#{v.to_s}"
        index += 1
        uri += '&' if index < params.size
      end
    end
    uri
  end
end