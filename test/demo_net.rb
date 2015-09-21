require 'net/http'
# puts Net::HTTP.get('www.baidu.com', '/index.html')
#puts Net::HTTP.get(uri)

uri = URI('http://180.76.156.183:80/v1/user/findByUserName?userName=Doby')
req = Net::HTTP::Post.new(uri)
# req.body =
req.content_type = 'application/json'

res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end

puts res.code
puts res.message
puts res.class.name
puts res.body

