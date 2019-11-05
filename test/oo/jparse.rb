require 'json'

def json_check_key(jsonstr,key)
end

def json_add_key(jsonstr,key,val)
end

def json_del_key(json,key)
end

def usage(ec,fmtstr)
	fout = $stderr
	if ec == 0 then
		fout = $stdout
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
	else
		$stderr.puts "#{ARGV[0]} not supported";
		exit(4);
	end
end