fibs = [1, 2]
sum = 2

loop do

  # Take advantage of the odd, odd, even pattern of the sequence
  3.times do
    fibs = [fibs[1], fibs[0] + fibs[1]]
  end

  if fibs[1] > 4000000
    break
  end

  sum += fibs[1]
end

puts sum
