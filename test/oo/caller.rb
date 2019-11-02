
class TraceBack
	attr_reader :linenum,:filename,:method

	def initialize(skip)
		begin
			s = caller[skip]
			sarr = s.split(':')
		rescue NoMethodError
			sarr = []
		end
		if sarr.length >= 3 then
			@filename=sarr[0]
			@linenum=sarr[1].to_i
			reex = Regexp.new("`<([^>]+)>'")
			ms = reex.match(sarr[2])
			if ms && ms.length >= 2 then
				@method=ms[1]
			else
				reex = Regexp.new("`([^'']+)'")
				ms = reex.match(sarr[2])
				if ms && ms.length >= 2 then
					@method=ms[1]
				else
					@filename=""
					@linenum=-1
				end
			end
		else
			@filename=""
			@linenum=-1
			@method=""
		end
	end

	def to_s()
		return sprintf("[%s:%s].[%s]", @filename,@linenum,@method)
	end
end

def func0(skip)
  func1(skip)
end

def func1(skip)
  func2(skip)
end


def func2(skip)
	func3(skip)
end

def func3(skip)
  tr = TraceBack.new(skip)
  puts "#{tr}"
  puts "#{tr.method} #{tr.filename} #{tr.linenum}"
end

func0(ARGV[0].to_i)