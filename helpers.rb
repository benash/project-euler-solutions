# irb:1> require 'helpers'
# => true
# irb:2> pl = PrimeList.new(10)
# => [false, false, true, true, false, true, false, true, false, false, false]
# irb:3> pl[5]
# => true
# irb:4> pl[6]
# => false
# irb:5> pl[10]
# => false
# irb:6> pl[11]
# => nil

class PrimeList < Array
  def initialize(max_prime)
    super(max_prime + 1, true)
    self[0] = false
    self[1] = false
    (4..max_prime).step(2) { |i| self[i] = false }

    max_factor = Math.sqrt(max_prime).to_i

    (3..max_factor).step(2) do |i|
      if self[i]
        (i*2..max_prime).step(i) do |j|
          self[j] = false
        end
      end
    end

  end
end

class PrimeFactorCount < Array
  def initialize(max_prime)
    super(max_prime + 1, 0)
    (4..max_prime).step(2) { |i| self[i] += 1 }

    (3..max_prime/2).step(2) do |i|
      if self[i] == 0
        (i*2..max_prime).step(i) do |j|
          self[j] += 1
        end
      end
    end

  end
end

class PrimeFactorList < Array
  def initialize(max_prime)
    super(max_prime + 1) { Array.new }
    (4..max_prime).step(2) { |i| self[i].push(2)}

    (3..max_prime/2).step(2) do |i|
      if self[i].size == 0
        (i*2..max_prime).step(i) do |j|
          self[j].push(i)
        end
      end
    end

  end
end

class Integer
  def gcd(i)
    j = self
    while j != 0
      t = j
      j = i % j
      i = t
    end
    i
  end

  def coprime?(i)
    self.gcd(i) == 1
  end
end
