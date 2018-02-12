#! /usr/bin/evn ruby -w

def stack1
	callers = caller
	callers.each { |a|
		puts "#{a}"
	}
	return nil
end

def stack2
	stack1
end

def stack3
	stack2
end

stack3