class Period
  attr_reader :start, :d

  def initialize(start, d)
    @start, @d = start, d
  end
end

def get_periods_from_list(list)
  diffs = []
  num_periods = 0
  (1...list.size).each do |i|
    diffs.push(list[i] - list[i-1])
    if diffs[0...i/2] == diffs[i/2..-1]
      num_periods = i / 2
      break
    end
  end

  periods = []
  (0...num_periods).each do |i|
    periods.push(Period.new(list[i], list[i+num_periods] - list[i]))
  end

  periods
end

class ConcealedSquare

  attr_reader :periods
  def initialize(periods=[Period.new(0, 10)])
    @periods = periods
  end

  def add_constraint(digit, location)
    limit = 10**(location + 1)
    divisor = 10**location
    matching_vals = []

    new_periods = []
    @periods.each do |p|
      matches = []
      (p.start..limit).step(p.d) do |i|
        if i**2 / divisor % 10 == digit
          matches.push(i)
        end
      end
      new_periods += get_periods_from_list(matches)
    end

    @periods = new_periods
  end

end

cs = ConcealedSquare.new

#cs.add_constraint(0, 0)
cs.add_constraint(9, 2)
cs.add_constraint(8, 4)
#cs.add_constraint(7, 6)
#cs.add_constraint(6, 8)
#cs.add_constraint(5, 10)
#cs.add_constraint(4, 12)

lower = Math.sqrt(1020304050607080900).ceil
upper = Math.sqrt(1929394959697989990).floor

matches = []

cs.periods.each do |p|
  start = p.start
  (start..upper).step(p.d) do |i|
    square = i**2
    if square / 1000000 % 10 == 7 &&
      square / 100000000 % 10 == 6 &&
      square / 10000000000 % 10 == 5 &&
      square / 1000000000000 % 10 == 4 &&
      square / 100000000000000 % 10 == 3 &&
      square / 10000000000000000 % 10 == 2 &&
      square / 1000000000000000000 % 10 == 1
      matches.push(i)
    end
  end
end

p matches.first
