module AntHttp
  require 'net/http'

  class HttpClient
    def initialize(uri, content_type='application/json')
      @uri = uri
      @content_type = content_type
    end

    def path(path)
      return if path.nil? || path == ''
      @uri.chomp!('/')
      @uri << '/' unless path.start_with? '/'
      @uri << path
      self
    end

    def params(params)
      @uri << to_url_params(params)
      self
    end

    def get
      uri = URI(@uri)
      req = Net::HTTP::Get.new(uri)
      execute(uri, req, nil)
    end

    def put(body=nil)
      uri = URI(@uri)
      req = Net::HTTP::Put.new(uri)
      execute(uri, req, body)
    end

    def post(body=nil)
      uri = URI(@uri)
      req = Net::HTTP::Post.new(uri)
      execute(uri, req, body)
    end

    def delete
      uri = URI(@uri)
      req = Net::HTTP::Delete.new(uri)
      execute(uri, req, body)
    end

    private

    def execute(uri, req, body)
      req.content_type = @content_type
      req.body=body unless body.nil?
      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end
      res
    end

    def to_url_params(params)
      uri = ''
      if params.size > 0
        uri << '?'
        index = 0
        params.each_pair do |k, v|
          uri << "#{k.to_s}=#{v.to_s}"
          index += 1
          uri << '&' if index < params.size
        end
      end
      uri
    end
  end
end