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
			@loggers = Hash.new(nil)
		end

		def set_format(logfmt)
			s = sprintf("proc do |serv,datetime,prog,msg| \"%s\" end", logfmt)
			@fmt = eval(s)
			@loggers.each { |key,log|
				log.formatter = @fmt
			}
			return self
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
			@loggers.each{ |key,log|
				log.level = @level
			}
			return self
		end

		def __format_msg(stacks,*msgs)
			stk = 6
			s = ""
			if msgs.length > 0 && stacks.is_a?(Integer) then
				stk = (stacks + 1)
				s = sprintf(*msgs)
			else
				s = sprintf(stacks,*msgs)
			end
			tr = TraceBack.new(stk)
			return sprintf("[%s:%d] #{s}", tr.filename,tr.linenum)
		end

		def baseconfig(loglvl,logfmt)
			return self.set_level(loglvl).set_format(logfmt)
		end

		def __is_has(name)
			return @loggers[name]
		end


		def fatal(*msgs)
			@loggers.each{ |key,log|
				log.fatal self.__format_msg(*msgs)
			}
			return self
		end

		def error(*msgs)
			@loggers.each{ |key,log|
				log.error self.__format_msg(*msgs)
			}
			return self
		end


		def warn(*msgs)
			@loggers.each{ |key,log|
				log.warn self.__format_msg(*msgs)
			}
			return self
		end

		def info(*msgs)
			@loggers.each{ |key,log|
				log.info self.__format_msg(*msgs)
			}
			return self
		end

		def debug(*msgs)
			@loggers.each{ |key,log|
				log.debug self.__format_msg(*msgs)
			}
			return self
		end

		def __append_logger(name,log)
			if @loggers[name] == nil then
				log.level = @level
				log.formatter = @fmt
				@loggers[name]= log
			end
		end

		def add_stdout(iserr)
			if iserr then
				name = "STDERR"
				if self.__is_has(name) == nil then
					self.__append_logger(name,Logger.new(STDERR))
				end
			else
				name = "STDOUT"
				if self.__is_has(name) == nil then
					self.__append_logger(name, Logger.new(STDOUT))
				end
			end
			return self
		end

		def add_file(fname,isappend)
			if isappend then
				name = File.expand_path(fname)
				if self.__is_has(name) == nil then
					log = Logger.new(fname,File::WRONLY| File::APPEND)
					self.__append_logger(name,log)
				end
			else
				name = File.expand_path(fname)
				if self.__is_has(name) == nil then
					fout = File.new(fname,'w')
					log = Logger.new(fout)
					self.__append_logger(name,log)
				end
			end
			self.__append_logger(name,log)
			return self
		end
	end

	class Logging
		@@logger = Hash.new(nil)
		def Logging.__check_create(name=nil)
			if @@logger[name] == nil then
				@@logger[name] = LoggingInner.new()
			end
			return @@logger[name]
		end

		def Logging.create(name=nil)
			return Logging.__check_create(name)
		end

		def Logging.add_stdout(iserr)
			Logging.__check_create().add_stdout(iserr)
		end

		def Logging.set_level(loglvl)
			Logging.__check_create().set_level(loglvl)
		end

		def Logging.add_file(fname,isappend)
			Logging.__check_create().add_file(fname,isappend)
		end


		def Logging.baseconfig(loglvl,logfmt)
			Logging.__check_create().baseconfig(loglvl,logfmt)
		end

		def Logging.fatal(*msgs)
			Logging.__check_create().fatal(*msgs)
		end

		def Logging.error(*msgs)
			Logging.__check_create().error(*msgs)
		end

		def Logging.warn(*msgs)
			Logging.__check_create().warn(*msgs)
		end

		def Logging.info(*msgs)
			Logging.__check_create().info(*msgs)
		end

		def Logging.debug(*msgs)
			Logging.__check_create().debug(*msgs)
		end
	end
