module AntHttp
  require 'net/http'

  class HttpClient
    def initialize(uri, content_type='application/json')
      @uri = uri.clone
      @content_type = content_type
      @params = nil
    end

    def path(path)
      return if path.nil? || path == ''
      @uri.chomp!('/')
      @uri << '/' unless path.start_with? '/'
      @uri << path
      self
    end

    def params(params)
      # @uri << to_url_params(params)
      @params = params
      self
    end

    def get
      uri = get_uri
      req = Net::HTTP::Get.new(uri)
      execute(uri, req, nil)
    end

    def put(body=nil)
      uri = get_uri
      req = Net::HTTP::Put.new(uri)
      execute(uri, req, body)
    end

    def post(body=nil)
      uri = get_uri
      req = Net::HTTP::Post.new(uri)
      execute(uri, req, body)
    end

    def delete
      uri = get_uri
      req = Net::HTTP::Delete.new(uri)
      execute(uri, req, body)
    end

    private

    def get_uri
      uri = URI(@uri)
      uri.query = URI.encode_www_form(@params) unless @params.nil?
      uri
    end

    def execute(uri, req, body)
      req.content_type = @content_type
      req.body=body unless body.nil?
      puts "execute uri: #{uri} "
      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end
      res
    end

    # def to_url_params(params)
    #   uri = ''
    #   if params.size > 0
    #     uri << '?'
    #     index = 0
    #     params.each_pair do |k, v|
    #       uri << "#{k.to_s}=#{v.to_s}"
    #       index += 1
    #       uri << '&' if index < params.size
    #     end
    #   end
    #   uri
    # end
  end
end