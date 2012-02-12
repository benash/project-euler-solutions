# We observe that the product of the first i prime numbers maximizes n/phi(n)
# Thus, we find the largest product of the first prime numbers <= 1000000
primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
product = 1

while product * primes.first <= 1000000
  product *= primes.shift
end

puts product
