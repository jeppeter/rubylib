require 'optparse'
require 'logging'

options = {}
options[:verbose] = 0
options[:log_appends] = []
options[:log_files] = []
options[:log_console] = true
OptionParser.new do |parser|
	parser.banner = "usage: cmdlog.rb [options]"
	parser.on("-v","--verbose" , "run verbose mode") do |v|
		options[:verbose] += 1
	end
	parser.on('--log-files files','log files truncated') do |v|
		options[:log_files] << v
	end

	parser.on('--log-appends append_files', 'log files appends') do |v|
		options[:log_appends] << v
	end

	parser.on('--no-log-console','no log console') do |v|
		options[:log_console] = false
	end
end.parse!

def set_log(opts)
	if opts[:log_console] then
		Logging.appenders.stderr('stderr')
	end
end


set_log(options)

Logging.debug "hello world"
Logging.warn "hello world"
Logging.error "hello world"
Logging.trace "hello world"
