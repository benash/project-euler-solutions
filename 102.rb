class Point
  attr_reader :x, :y, :quadrant

  def initialize(coords)
    @x, @y = coords
    set_quadrant
  end

  def set_quadrant
    @quadrant = if @y > 0
      @x > 0 ? 1 : 2
    else
      @x > 0 ? 4 : 3
    end
  end

  def line_with(point)
    Line.new(self, point)
  end
end

class Line
  attr_reader :m, :y_int

  def initialize(a, b)
    @a, @b = a, b
    @m = (b.y - a.y) / (b.x - a.x).to_f
    @y_int = (@m * -a.x) + a.y
  end
end

class Triangle
  def initialize(points)
    @points = points.collect { |p| Point.new(p) }
    arrange_points
    @num_quads = @points.collect { |p| p.quadrant }.uniq.size
  end

  def feasible_quadrants?
    ordered_quadrants = @points.collect { |p| p.quadrant }.uniq.sort

    @num_quads == 3 ||
      ordered_quadrants == [1, 3] ||
      ordered_quadrants == [2, 4]
  end

  def arrange_points
    @points = @points.sort_by { |p| p.quadrant }
    case @points.collect { |p| p.quadrant }
    when [1, 2, 3]
      @points = [@points[2], @points[1], @points[0]]
    when [1, 2, 4]
      @points = [@points[2], @points[0], @points[1]]
    when [1, 3, 4]
      @points = [@points[0], @points[2], @points[1]]
    when [1, 1, 3], [2, 2, 4]
      @points = [@points[2], @points[1], @points[0]]
    when [1, 3, 3]
    when [2, 4, 4]
    end
  end

  def side_opposite_point?
    x1 = @points[0].x
    y1 = @points[0].y
    x2 = @points[2].x
    y2 = @points[2].y

    (y1 / x1.to_f).abs >= (y2 / x2.to_f).abs
  end

  def side_opposite_side?
    (@points[0].line_with(@points[1]).y_int <=> 0) !=
      (@points[0].line_with(@points[2]).y_int <=> 0)
  end

  def includes_origin?
    if feasible_quadrants?
      case @num_quads
      when 2 then side_opposite_side?
      when 3 then side_opposite_point?
      end
    else
      false
    end
  end
end

triangle_vals = IO.readlines('triangles.txt').collect do |i|
  i.chomp.split(',').collect do |j| 
    j.to_i
  end.each_slice(2).to_a
end

triangles = triangle_vals.collect do |vals|
  Triangle.new(vals)
end

p triangles.count {|t| t.includes_origin? }

