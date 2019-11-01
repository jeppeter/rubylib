#! /usr/bin/env ruby

def read_file(fname)
	f = File.open(fname, "r")
	data = f.readlines();
	f.close
	return data
end

def one_line(fname, l)
	p "#{fname} #{l}"
end

for c in ARGV do
	p "read #{c}"
	read_file(c).each{ |l|
		print "#{l}";
	}
end