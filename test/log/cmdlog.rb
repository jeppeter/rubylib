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
	attr_accessor :loggers,:level,:name
	def initialize(level=Logger::ERROR,name=nil)
		@loggers = []
		@level = level
		@name = name
	end

	def add_file_append(outfile)
		f = File.open(outfile, File::WRONLY | File::APPEND | File::CREAT)
		log = Logger::new(f)
		@loggers << log
	end

	def add_file(outfile)
		f = File.open(outfile, File::WRONLY |  File::CREAT)
		log = Logger::new(f)
		@loggers << log
	end

	def console_log()
		log = Logger.new(STDERR)
		@loggers << log
	end

	def warn(msg)
		sarr = caller[0].split(':')
		@loggers.each{|x|
			x.warn('['+sarr[0]+':'+ sarr[1]+'] ' + msg)
		}
	end

	def info(msg)
		sarr = caller[0].split(':')
		@loggers.each{|x|
			x.info('['+sarr[0]+':'+ sarr[1]+'] ' + msg)
		}
	end

	def error(msg)
		sarr = caller[0].split(':')
		@loggers.each{|x|
			x.error('['+sarr[0]+':'+ sarr[1]+'] ' + msg)

		}
	end

	def debug(msg)
		sarr = caller[0].split(':')
		@loggers.each{|x|
			x.debug('['+sarr[0]+':'+ sarr[1]+'] ' + msg)
		}
	end

	def fatal(msg)
		sarr = caller[0].split(':')
		@loggers.each{|x|
			x.fatal('['+sarr[0]+':'+ sarr[1]+'] ' + msg)
		}
	end
end



def set_log(opts)
	log = nil
	level = Logger::ERROR
	if opts[:verbose] >= 3 then
		level = Logger::DEBUG
	elsif  opts[:verbose] >= 2 then
		level = Logger::INFO
	elsif  opts[:verbose] >= 1 then
		level = Logger::WARN
	end
			

	if log.nil? then
		log = CompoundLogger.new(level)
	end

	if opts[:log_console] then
		log.console_log()
	end

	opts[:log_appends].each { |x|
		log.add_file_append(x)
	}

	opts[:log_files].each { |x|
		log.add_file(x)
	}

	return log
end


log = set_log(options)

log.debug "hello world"
log.warn "hello world"
log.error "hello world"
log.info "hello world"
log.fatal "hello world"
