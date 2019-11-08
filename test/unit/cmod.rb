
module Cmod
	def CFunc(arg1,arg2)
		puts "CFunc arg1 #{arg1} arg2 #{arg2}"
		return "CFunc"
	end

	def BFunc(arg1,arg2)
		puts "BFunc arg1 #{arg1} arg2 #{arg2}"
		return "BFunc"
	end
end

class CLss
	def CLss.create(arg1,arg2)
		puts "CLss arg1 #{arg1} arg2 #{arg2}"
		return "CLss.create"
	end
end