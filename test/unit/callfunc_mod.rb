
def callfunc(fn,*args)
	s = sprintf("%s(*args)", fn)
	return eval s;
end
