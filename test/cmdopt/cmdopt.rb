#! /usr/bin/env ruby -w

require 'optparse'
require 'ostruct'

options = OpenStruct.new
options.integer = 0
options.select = false
options.float = 0.0
options.string = ""
options.append = []
OptionParser.new do |opts|
	opts.version = '0.1.0'
	opts.banner += '[commands] [...arguments]'
	opts.on('-S','--select','enable selected mode'){options.select = true}
	opts.on('-i','--integer integerval','set integer number') {|opt| 
		if  opt.to_i? then
	 		options.integer = opt.to_i
	 	else
	 		
	 	end
	 	}
	opts.on('-s','--string stringval','set string value') {|opt| options.string = opt}
	opts.on('-f','--float floatval','set float value') {|opt| options.float = opt.to_f}
	opts.on('-a','--append appendval','set append value') {|opt| 
		options.append << opt
	}

	begin
		opts.parse!
	rescue OptionParser::ParseError => error
		$stderr.puts error
		exit 1
	end
end

print <<EOFFF
selectmode: #{options.select}
integer: #{options.integer}
string: \"#{options.string}\"
float: #{options.float}
append: #{options.append}
EOFFF


