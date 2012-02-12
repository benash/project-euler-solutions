N = 1000000
min_diff = Float::MAX
best_n = 0
best_d = 0

three_sevenths = 3/7.0

(2..N).each do |d|
  frac_n = three_sevenths * d
  n = frac_n.floor
  diff = (frac_n - n) / d
  if diff == 0
    next
  end

  if diff < min_diff
    min_diff = diff
    best_n = n
    best_d = d
  end
end

puts best_n
