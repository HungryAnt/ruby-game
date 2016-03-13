1.upto(15) do |num|
  id = "#{'%04d' % num}"
  puts id
  system "RubyGameImageTool.exe  D:\\dev\\ruby\\ruby-game\\media\\img\\wild_monster\\#{id}"
end