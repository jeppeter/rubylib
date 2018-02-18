#! /usr/bin/env ruby -w

require 'thread'



class LogClone
	def initialize(logname,loglevel,logfmt)
		@logname= logname
		@loglevel = loglevel
		@logfmt = logfmt
		@thr = nil
		@exited = true
		@exitcode = 0
		@queue = nil
	end

	def start_run()
		if ! @exited 
			return -1
		end
		
	end
end