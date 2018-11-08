#! /usr/bin/env ruby

str = ""
if ARGV.length < 5
	then
	if ARGV.length >= 2
		then
		str <<= ARGV[0]%ARGV[1]
	end
end
puts "#{str}"
