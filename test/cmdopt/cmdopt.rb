#! /usr/bin/env ruby -w

require 'optparse'

options = {}
OptionParser.new do |opts|
	opts.version = '0.1.0'
	opts.banner += '[commands] [...arguments]'
	opts.on('-S','--select','enable selected mode'){options[:selected] = true}
	opts.on('-i','--integer integerval','set integer number') {|opt| options[:integer] = opt.to_i}
	opts.on('-s','--string stringval','set string value') {|opt| options[:string] = opt}
	opts.on('-f','--float floatval','set float value') {|opt| options[:float] = opt.to_f}
	opts.on('-a','--append appendval','set append value') {|opt| 
		arr = options.fetch('append',[])
		arr.push(opt)
		puts "arr #{arr}"
		options[:append] = arr
	}

	begin
		opts.parse!
	rescue OptionParser::ParseError => error
		$stderr.puts error
		exit 1
	end
end

print <<EOFFF
selectmode: #{options.fetch("select",false)}
integer: #{options.fetch("integer",0)}
string: \"#{options.fetch("string","")}\"
float: #{options.fetch("float",0.0)}
append: #{options.fetch("append",[])}
EOFFF


