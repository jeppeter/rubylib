
class OO
	def OO.varfunc(*more)
		if more.length > 1 then
			if more[0].is_a? Integer then
				puts "integer #{more[0]}"
			end
			puts "#{more[1]}"
		else
			puts "#{more[0]}"
		end
	end
end

OO.varfunc("hello %s"%"world")
OO.varfunc(2,"hello %s"%"world")