

class Point
	@x = 0
	@y = 0
	attr :x,true 
	attr :y,true
	def initialize(x,y)
		@x = x
		@y = y
	end

	def to_s()
		return sprintf("x=%s;y=%s", @x,@y)
	end

	def ==(o)
		if o.is_a? Point
			@x == o.x && @y == o.y
		else
			false
		end
	end

	def !=(o)
		if o.is_a? Point
			@x != o.x || @y != o.y
		else
			true
		end
	end

end

p = Point.new(3,1)
puts "p #{p} p.x #{p.x} p.y #{p.y}"

p.x = 100
p.y = 300
puts "p #{p} p.x #{p.x} p.y #{p.y}"

p2 = Point.new(102,302)
if p == p2 then
	puts "#{p} equal #{p2}"
else
	puts "#{p} not equal #{p2}"
end

if p != p2 then
	puts "#{p} != #{p2}"
else
	puts "#{p} == #{p2}"
end