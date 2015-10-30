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
      @params = params
      self
    end

    def get
      run Net::HTTP::Get
    end

    def put(body=nil)
      run Net::HTTP::Put, body
    end

    def post(body=nil)
      run Net::HTTP::Post, body
    end

    def delete
      run Net::HTTP::Delete
    end

    private

    def run(clazz, body=nil)
      uri = get_uri
      req = clazz.new(uri)
      execute(uri, req, body)
    end

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
  end
end