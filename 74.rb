$chain_sizes = Array.new
$chain_sizes[871] = 2
$chain_sizes[872] = 2
$chain_sizes[45361] = 2
$chain_sizes[45362] = 2
$chain_sizes[169] = 3
$chain_sizes[1454] = 3
$chain_sizes[363601] = 3

$factorials = [1] + (1..9).collect {|i| i.downto(1).to_a.reduce(:*)}

class Integer
  def fact_sum
    q = self
    res = 0
    while q > 0
      q, rem = q.divmod(10)
      res += $factorials[rem]
    end
    res
  end
end

def chain_size(n)
  if $chain_sizes[n].nil?
    next_in_chain = n.fact_sum
    if next_in_chain == n
      $chain_sizes[n] = 1
    else
      $chain_sizes[n] = 1 + chain_size(next_in_chain)
    end
  end
  $chain_sizes[n]
end

puts (1..1000000).count { |i| chain_size(i) == 60 }
