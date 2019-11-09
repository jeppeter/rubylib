
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

class BaseException < Exception
	attr_reader :tr,:msg
	def initialize(msg)
		@tr = TraceBack.new(2)
		@msg = msg
	end

	def to_s()
		return sprintf("[%s:%d]:#{@msg}",@tr.filename,@tr.linenum);
	end
end


begin
	raise BaseException.new("init msg")
rescue BaseException => e
	puts "#{e}"
end
