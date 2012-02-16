class Rectangle

  attr_reader :w, :h, :sub_rects

  def initialize
    @w = 0
    @h = 0
    @sub_rects = 0
  end

  def set_square(len)
    @w = len
    @h = len
    @sub_rects = ((len + 1) * len / 2)**2
  end

  def incr_w
    @w += 1
    @sub_rects += @w * ((@h + 1) * @h / 2)
  end

  def decr_h
    @sub_rects -= @h * ((@w + 1) * @w / 2)
    @h -= 1
  end

  def area
    @h * @w
  end

end

class Tracker

  attr_reader :best_obj

  def initialize(n, method)
    @n, @method = n, method
    @best_diff = n
  end

  def record(obj)
    val = obj.method(@method).call
    diff = (@n - val).abs
    if diff < @best_diff
      @best_diff = diff
      @best_obj = obj.clone
    end
  end

end

N = 2000000
tracker = Tracker.new(N, :sub_rects)

rect = Rectangle.new
i = 1

while rect.sub_rects < N
  rect.set_square(i)
  tracker.record(rect)
  i += 1
end

while rect.h > 1
  while rect.sub_rects > N
    rect.decr_h
    tracker.record(rect)
  end

  while rect.sub_rects < N
    rect.incr_w
    tracker.record(rect)
  end
end

p tracker.best_obj.area

