
def match(restr,instr)
	reex = Regexp.new(restr)
	if reex.match(instr) then
		puts "#{instr} match #{restr}"
	else
		puts "#{instr} not match #{restr}"
	end
end

def find(restr,instr)
	reex = Regexp.new(restr)
	ms = reex.match(instr)
	if ms then
		i = 0 
		puts "#{instr} find #{restr}"
		while i < ms.length
			s = sprintf("\t[%d]%s",i,ms[i])
			puts "#{s}"
			i = i + 1
		end
	else
		puts "#{instr} no find #{restr}"
	end
end

def usage(ec,fmtstr)
	fout = $stderr;
	if ec == 0 then
		fout = $stdout;
	end

	if fmtstr && fmtstr.length > 0 then
		fout.puts "#{fmtstr}"
	end

	fout.puts "retest  [subcommands]";
	fout.puts "[subcommands]";
	fout.puts "\tmatch     restr instr ....               to make match string";
	fout.puts "\tfind      restr instr ....               to find the brackets";

	exit(ec);
end

if ARGV.length > 0 then
	if ARGV[0] == "match" then
		if ARGV.length < 3 then
			usage(4,"need 3 args")
		end
		i = 2
		while i < ARGV.length
			match(ARGV[1],ARGV[i])
			i = i + 1
		end
	elsif ARGV[0] == "find" then
		if ARGV.length < 3 then
			usage(4,"need 3 args")
		end
		i = 2
		while i < ARGV.length
			find(ARGV[1],ARGV[i])
			i = i + 1
		end

	elsif ARGV[0] == "-h" || ARGV[0] == "--help" then
		usage(0,"");
	else
		usage(3,"not support command #{ARGV[0]}")
	end
else
	usage(3,"need a subommand")
end