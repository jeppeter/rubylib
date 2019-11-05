require 'logger'

class TraceBack
	attr_reader :linenum,:filename,:method

	def initialize(skip)
		begin
			s = caller[skip]
			sarr = s.split(':')
		rescue NoMethodError
			sarr = []
		end
		if sarr.length >= 3 then
			@filename=sarr[0]
			@linenum=sarr[1].to_i
			reex = Regexp.new("`<([^>]+)>'")
			ms = reex.match(sarr[2])
			if ms && ms.length >= 2 then
				@method=ms[1]
			else
				reex = Regexp.new("`([^'']+)'")
				ms = reex.match(sarr[2])
				if ms && ms.length >= 2 then
					@method=ms[1]
				else
					@filename=""
					@linenum=-1
				end
			end
		else
			@filename=""
			@linenum=-1
			@method=""
		end
	end

	def to_s()
		return sprintf("[%s:%s].[%s]", @filename,@linenum,@method)
	end
end


class LoggingInner
	@loggers
	@level
	@fmt 
	def initialize()
		@level = Logger::ERROR
		@fmt = proc do |serv,datetime,prog,msg|"#{serv} #{datetime}: #{msg}\n" end
		@loggers = []
	end

	def set_format(logfmt)
		s = sprintf("proc do |serv,datetime,prog,msg| \"%s\" end", logfmt)
		@fmt = eval(s)
		@loggers.each { |log|
			log.formatter = @fmt
		}
	end

	def set_level(loglvl)
		setlvl = Logger::ERROR
		if loglvl <= 0 then
			setlvl = Logger::FATAL
		elsif  loglvl > 0 &&  loglvl <= 10 then
			setlvl = Logger::ERROR
		elsif  loglvl > 10 &&  loglvl <= 20 then
			setlvl = Logger::WARN
		elsif  loglvl > 20 &&  loglvl <= 30 then
			setlvl = Logger::INFO
		elsif  loglvl > 30  then
			setlvl = Logger::DEBUG
		end
		@level = setlvl
		@loggers.each{ |log|
			log.level = @level
		}
	end

	def __format_msg(stacks,*msgs)
		stk = 6
		s = ""
		if msgs.length > 0 && stacks.is_a?(Integer) then
			stk = stacks
			s = sprintf(*msgs)
		else
			s = sprintf(stacks,*msgs)
		end
		tr = TraceBack.new(stk)
		return sprintf("[%s:%d] #{s}", tr.filename,tr.linenum)
	end


	def fatal(*msgs)
		@loggers.each{ |log|
			log.fatal self.__format_msg(*msgs)
		}
	end

	def error(*msgs)
		@loggers.each{ |log|
			log.error self.__format_msg(*msgs)
		}
	end


	def warn(*msgs)
		@loggers.each{ |log|
			log.warn self.__format_msg(*msgs)
		}
	end

	def info(*msgs)
		@loggers.each{ |log|
			log.info self.__format_msg(*msgs)
		}
	end

	def debug(*msgs)
		@loggers.each{ |log|
			log.debug self.__format_msg(*msgs)
		}
	end

	def __append_logger(log)
		log.level = @level
		log.formatter = @fmt
		@loggers.push(log)
	end

	def add_stdout(iserr)
		if iserr then
			log = Logger.new(STDERR)
		else
			log = Logger.new(STDOUT)
		end
		self.__append_logger(log)
	end

	def add_file(fname,isappend)
		if isappend then
			log = Logger.new(fname,File::WRONLY| File::APPEND)
		else
			fout = File.new(fname,'w')
			log = Logger.new(fout)
		end
		self.__append_logger(log)
	end
end

class Logging
	@@logger = nil
	def Logging.__check_create()
		if @@logger == nil then
			@@logger = LoggingInner.new()
		end
	end

	def Logging.add_stdout(iserr)
		Logging.__check_create()
		@@logger.add_stdout(iserr)
	end

	def Logging.set_level(loglvl)
		Logging.__check_create()
		@@logger.set_level(loglvl)
	end

	def Logging.add_file(fname,isappend)
		Logging.__check_create()
		@@logger.add_file(fname,isappend)
	end


	def Logging.baseconfig(loglvl,logfmt)
		Logging.__check_create()
		@@logger.set_level(loglvl)
		@@logger.set_format(logfmt)
	end

	def Logging.fatal(*msgs)
		Logging.__check_create()
		@@logger.fatal(*msgs)
	end

	def Logging.error(*msgs)
		Logging.__check_create()
		@@logger.error(*msgs)
	end

	def Logging.warn(*msgs)
		Logging.__check_create()
		@@logger.warn(*msgs)
	end

	def Logging.info(*msgs)
		Logging.__check_create()
		@@logger.info(*msgs)
	end

	def Logging.debug(*msgs)
		Logging.__check_create()
		@@logger.debug(*msgs)
	end
end

Logging.baseconfig(50, "\#{datetime} \#{msg}\n")
Logging.add_stdout(false)
Logging.add_file('new.log', false)
Logging.add_file('app.log', true)

Logging.fatal "call first"
Logging.error "call first"
Logging.warn "call first"
Logging.info "call first"
Logging.debug "call first"


Logging.baseconfig(20,"\#{serv} \#{datetime} \#{msg}\n")
Logging.fatal "call second"
Logging.error "call second"
Logging.warn "call second"
Logging.info "call second"
Logging.debug "call second"