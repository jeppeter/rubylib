require 'optparse'
require 'Logger'

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

class CompoundLogger
	def initialiazer(level)
		@loggers = []
		@level  = level
	end

	def add_file_append(name)
		log = Logger.new(name, File::WRONLY | File::APPEND)
		@loggers << log
	end

	def add_file(name)
		log = Logger.new(name, File::WRONLY |  File::CREAT)
		@loggers << log
	end

	def console_log()
		log = Logger.new(STDERR)
		@loggers << log
	end

	def warn(msg)
	end
end

def set_log(opts)
	if opts[:log_console] then
		
	end
end


set_log(options)

Logger.debug "hello world"
Logger.warn "hello world"
Logger.error "hello world"
Logger.trace "hello world"
