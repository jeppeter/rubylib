
require_relative "callfunc_mod"
require_relative "cmod"



def func1(arg1,arg2)
	puts "func1 arg1 #{arg1} arg2 #{arg2}";
	return "func1";
end

def func2(arg1,arg2)
	puts "func2 arg1 #{arg1} arg2 #{arg2}";
	return "func2";
end



s = callfunc("func1","www","ccc")
puts "return val #{s}"

s = callfunc("func2","www2","ccc2")
puts "return val #{s}"


s = callfunc("CLss.create","www","ccc")
#s = CLss.create("wwww","ccc")
puts "return val #{s}"
