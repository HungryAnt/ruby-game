
# 1/a - 1/b = (b - a)/(a * b) = x / y = 1 / (y/x) = 1 / c

results = []
1.upto(69) do |i|
  x = 70 - i
  y = 70 * i
  if y % x == 0
    c = y / x
    results <<  "1/#{i} - 2/#{c*2} = 1/70"
  end
end

puts "count: #{results.length}"
results.each {|r| puts r}