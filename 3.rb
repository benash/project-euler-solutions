n = 600851475143

# We see by inspection that n is not divisible by 2, so we start with 3
divisor = 3

loop do

  quotient, remainder = n.divmod(divisor)

  if quotient < divisor
    break
  end

  if remainder == 0
    n = quotient
  else
    divisor += 2
  end

end

puts n
