require 'socket';

host = "0.0.0.0"
port = 3921
if ARGV.length > 0 then
	host = ARGV[0]
	end
if ARGV.length > 1 then
	port = ARGV[1].to_i
end

serv = TCPServer.new(host, port)
loop{
	Thread.start(serv.accept) do  |cli|
		cli.puts "#{Time.now}"
		cli.close
	end
}
