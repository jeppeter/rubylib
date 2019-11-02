require 'socket';

host = '127.0.0.1';
port = 3912;

if ARGV.length > 0 then
	host = ARGV[0]
end

if ARGV.length > 1 then
	port = ARGV[1].to_i
end


puts "connect [#{host}:#{port}]";
client = TCPSocket.open(host,port);

while s = client.gets
	puts s;
end
client.close