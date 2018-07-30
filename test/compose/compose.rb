

def compose2(f,g)
	lambda { |x| f.call(g.call(x))}
end

def compose(*fns)
	fns.reduce { |f,g| lambda { |x| f.call(g.call(x)) }}
end

addone = lambda { |x| x + 1 }
twiceone = lambda {|x| x * 2}

c = compose2(addone,twiceone).call(3)
p "c #{c}"