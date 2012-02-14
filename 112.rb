class Counter < Array
  def initialize
    super(1, 0)
  end

  def incr
    incr_at(self.length-1)
    self
  end

  def incr_at(i)
    self[i] += 1
    if self[i] == 10
      self[i] = 0
      if i == 0
        unshift(1)
      else
        incr_at(i-1)
      end
    end
  end

  def bouncy?
    (0..length-2).any? { |i| self[i] < self[i+1] } && 
      (0..length-2).any? { |i| self[i] > self[i+1] }
  end
end

BOUNCY_PERCENTAGE = 99

$bouncy_count = 0
$non_bouncy_count = 0
$total = 0

$c = Counter.new

def record_bouncy
  $c.incr
  if $c.bouncy?
    $bouncy_count += 1
  else
    $non_bouncy_count += 1
  end
  $total += 1
end

2.times do
  record_bouncy
end

while $bouncy_count < 0.99 * $total
  record_bouncy
end

p $total
