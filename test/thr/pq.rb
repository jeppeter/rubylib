#! /usr/bin/env ruby -w

require 'thread'



class LogClone
	def initialize(logname,loglevel,logfmt)
		@logname= logname
		@loglevel = loglevel
		@logfmt = logfmt
		@thr = nil
		@exited = true
		@exitflag = false
		@mutex = nil
		@exitcode = 0
		@queue = nil
	end

	def insert_queue(obj)
		@mutex.synchronize {
			@queue.push(obj)
		}
	end

	def start_run()
		if ! @exited 
			return -1
		end
		__inner_free = lambda {   
			if @thr != nil && ! @exited {
				@exitflag = true
				while ! @exited {
					sleep 0.1
					insert_queue(nil)
				}
			}
		} 



	end
end