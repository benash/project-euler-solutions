BASE = 0
EXPONENT = 1

numbers = IO.readlines("base_exp.txt").collect{|x| x.chomp.split(",").collect {|y| y.to_i} }

max_base = numbers.max_by {|x| x[BASE] }[BASE]
max_base_log = Math.log(max_base)

numbers.each_index do |i|
  numbers[i][EXPONENT] /= (max_base_log / Math.log(numbers[i][BASE]))
  numbers[i][BASE] = max_base
end

max_index = numbers.each_with_index.max_by {|x| x[0][EXPONENT]}[1]
max_line_number = max_index + 1

puts max_line_number
