require 'helpers'
MAX_D = 12000
START = 5

total = 0

prime_factors = PrimeFactorList.new(MAX_D)

START.upto(MAX_D) do |d|

  upper_n = d / 2
  lower_n = d / 3 + 1

  factors = prime_factors[d]

  total += upper_n - lower_n + 1

  k = 1
  (1..factors.size).each do |n|
    k ^= -2
    factors.combination(n) do |c|
      prod = c.reduce(:*)
      total += k * (upper_n / prod - (lower_n - 1) / prod)
    end
  end

end

puts total
