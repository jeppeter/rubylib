require 'json'

def json_check_key(jsonstr,key)
	jhash = JSON.parse(jsonstr)
	if jhash.key?(key) then
		puts "[#{jsonstr}] has key[#{key}]"
	else
		puts "[#{jsonstr}] not has key[#{key}]"
	end
	return
end

def json_add_key(jsonstr,key,val)
	jhash = JSON.parse(jsonstr)
	jhash[key] = JSON.parse(val)
	s = JSON.generate(jhash)
	puts "[#{jsonstr}] add [#{key}] [#{val}] [#{s}]"
	return
end

def json_del_key(jsonstr,key)
	jhash = JSON.parse(jsonstr)
	if jhash.key?(key) then
		jhash.delete(key)
		s = JSON.generate(jhash)
		puts "[#{jsonstr}] del [#{key}] [#{s}]"
	else
		puts "[#{jsonstr}] not hash [#{key}]"
	end
end

def usage(ec,fmtstr)
	fout = $stderr
	if ec == 0 then
		fout = $stdout
	end

	if fmtstr.length > 0 then
		fout.puts "#{fmtstr}"
	end

	fout.puts "jparse [SUBCOMMAND]";
	fout.puts "[SUBCOMMAND]";
	fout.puts "\tcheck     jsonstr    keystr                  to check string key";
	fout.puts "\tadd       jsonstr    keystr   valuestr       to add key value";
	fout.puts "\tdel       jsonstr    keystr                  to delete key";

	exit(ec);
end

if ARGV.length > 0 then
	if ARGV[0] == "check" then
		if ARGV.length < 3 then
			usage(3,"check need 3 args");
		end
		json_check_key(ARGV[1],ARGV[2])
	elsif ARGV[0] == "add" then
		if ARGV.length < 4 then
			usage(3, "add need 4 args");
		end
		json_add_key(ARGV[1],ARGV[2],ARGV[3])
	elsif ARGV[0] == "del" then
		if ARGV.length < 3 then
			usage(3,"del need 3 args")
		end
		json_del_key(ARGV[1],ARGV[2])
	elsif ARGV[0] == "-h" || ARGV[0] == "--help" then
		usage(0,"")
	else
		$stderr.puts "#{ARGV[0]} not supported";
		exit(4);
	end
end