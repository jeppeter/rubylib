#! /usr/bin/env ruby

def read_file(fname)
	f = File.open(fname, "r")
	data = f.read
	f.close
	return data
end

def one_line(fname, l)
	p "#{fname} #{l}"
end

for c in ARGV do
	p "read #{c}"
	p read_file(c)
end