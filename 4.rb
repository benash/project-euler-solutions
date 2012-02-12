max = 0
999.downto(100) do |i|
  999.downto(i) do |j|
    prod = i * j
    # When prod <= max, we shortcut the expensive string manipulation
    if prod > max && (prod == prod.to_s.reverse.to_i)
      max = prod
    end
  end
end

puts max
