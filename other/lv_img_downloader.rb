require 'open-uri'

def download(num_from, num_to)
  num_from.upto(num_to) do |num|
    url = "http://image2.sina.com.cn/igame/new/new011/help/game/yaburi/lv_#{num}.gif"
    open(url) do |fin|
      size = fin.size
      download_size = 0
      puts "size: #{size}"
      filename = url[url.rindex('/')+1, url.length-1]
      puts "name: #{filename}"
      Dir.mkdir('lv_images') unless Dir.exist? 'lv_images'
      open("lv_images/#{filename}", 'wb') do |fout|
        while (buf = fin.read(1024)) do
          fout.write buf
          download_size += 1024
          print "Downloaded #{download_size * 100 / size}%\r"
          STDOUT.flush
        end
      end
    end
  end
end

download(1, 10)