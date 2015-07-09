require_relative 'player'

# print "yourname:"
# name = gets.chomp
name = 'ant'

player = Player.new
player.name = name

puts "Hello #{player.name}"


1.upto(10) { |n| player.level_up; puts player.level}
puts "level #{player.level}"