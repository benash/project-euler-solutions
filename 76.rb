N = 100

a = Array.new(N+1) { Array.new }

(1..N).each do |i|
  a[0][i] = 1
  a[1][i] = 1
end

2.upto(N) do |row|
  a[row][1] = 1

  2.upto(row) do |col|
    a[row][col] = a[row][col-1] + a[row-col][col]
  end

  (row+1).upto(N) do |col|
    a[row][col] = a[row][col-1]
  end
end

puts a[-1][-2]
