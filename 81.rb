N = 80

a = IO.readlines("matrix.txt").collect{|x| x.split(",").collect{|y| y.to_i}}

(1..N-1).each do |i|
  a[i][0] += a[i-1][0]
  a[0][i] += a[0][i-1]
end

(1..N-1).each do |i|
  (1..N-1).each do |j|
    a[i][j] += [a[i-1][j], a[i][j-1]].min
  end
end

puts a[N-1][N-1]
